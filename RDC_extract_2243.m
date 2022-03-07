function RDC = RDC_extract_2243(fNameIn)
    fileID = fopen(fNameIn, 'r'); % open file
    Data = fread(fileID, 'int16');% DCA1000 should read in two's complement data
    fclose(fileID); % close file
    
    fileSize = size(Data, 1);
    isBPM = 1;
    isTDM = 1;
    numRX = 4;
    NTS = 256; % Number of time samples per sweep
    numChirps = ceil(fileSize/2/NTS/numRX);
    
    %% Organize data per RX
    
    zerostopad = NTS*numChirps*numRX*2-length(Data);
    Data = [Data; zeros(zerostopad,1)];
    
    Data = reshape(Data, 2*numRX, []);
    Data = Data(1:4,:) + sqrt(-1)*Data(5:8,:);                                  
    Data = Data.';
    
    RDC = reshape(Data,NTS,numChirps,numRX); 
    
    
    %% If BPM, i.e. numTX = 2, see MIMO Radar sec. 4.2
    
    if isBPM && isTDM
            % decompose the chirps
            chirp1 = 1/2 * (RDC(:, 1:3:end, :) + RDC(:, 2:3:end, :));
            chirp2 = 1/2 * (RDC(:, 1:3:end, :) - RDC(:, 2:3:end, :));
            chirp3 = RDC(:, 3:3:end, :); % elevation
            RDC = cat(3, chirp1, chirp2, chirp3);
    end
    
end
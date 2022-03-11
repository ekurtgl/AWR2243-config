from RDC_extract_2243 import RDC_extract_2243
from RDC_to_microDoppler_2243 import RDC_microDoppler
from RDC_to_rangeDOA_2243_azimuth import RDC_to_DOA_az_2243

main = '/media/emre/Windows-SSD/Users/emrek/Desktop/Technical/77ghz/data/'
fname = 'hand_rightleft_Raw_0.bin'
fin = main + fname
out = '/home/emre/PycharmProjects/RadarGUI/data/'
fout = out + fname

RDC, params = RDC_extract_2243(fin)
# RDC_microDoppler(RDC, fout, params)
RDC_to_DOA_az_2243(RDC, fout, params, K=1, M=10, MTI=False)


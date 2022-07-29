import os

import pandas as pd
import re


ALPHABET = ['A', 'B', 'C', 'D', 'E', 'F', 'G', 'H', 'I', 'J', 'K', 'L', 'M', 'N', 'O', 'P', 'Q', 'R' 'S', 'T', 'U', 'V', 'W', 'X', 'Y', 'Z']


if __name__ == '__main__':
	
        
    df_data = pd.read_csv(os.path.dirname(__file__) + '/../data/Traffic_camera_offences_and_fines.csv')
    df_location = pd.read_csv(os.path.dirname(__file__) + '/../data/Traffic_Camera_Locations.csv')
    df_location = df_location.dropna()
    
    #Create a dictionary with location codes as keys and coordinates as values
    codes_dict = {}
    for index, row in df_location.iterrows():
        code = row['CAMERA LOCATION CODE']
        if code[-1] in ALPHABET:
            code = code[:-1]
        coordinates = row['Location']
        coordinates = re.findall(r"[-+]?\d*\.\d+|\d+", coordinates)
        lat = coordinates[0]
        lon = coordinates[1]
        codes_dict[code] = {}
        codes_dict[code]['lat'] = lat
        codes_dict[code]['lon'] = lon
    
        
    def assign_lat(row):
        try:
            
            return(codes_dict[str(row['Location_Code']).zfill(4)]['lat'])
        except KeyError:
            print(str(row['Location_Code']))
            
    def assign_lon(row):
        try:
            return(codes_dict[str(row['Location_Code']).zfill(4)]['lon'])
        except KeyError:
            pass
        
    #Put coordinate values in table
    #About half the incidents are missing geographic data
    df_data['lat'] = df_data.apply(lambda row : assign_lat(row), axis=1)
    df_data['lon'] = df_data.apply(lambda row : assign_lon(row), axis=1)
    
    df_data.to_csv(os.path.dirname(__file__) + "/../data/traffic_camera_offences_geographic.csv")
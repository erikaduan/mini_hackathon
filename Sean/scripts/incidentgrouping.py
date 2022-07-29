import pandas as pd



if __name__ == '__main__':
    
    df = pd.read_csv("data/traffic_camera_offences_geographic.csv")
    df = df.dropna()

    camera_counts = {}
    
    #Create a dictionary with the location codes as keys
    for index, row in df.iterrows():
        
        code = row['Location_Code']
        if code in camera_counts:
            camera_counts[code]['total_pen'] += row['Sum_Pen_Amt']
            camera_counts[code]['total_incidents'] += 1
        else:
            camera_counts[code] = {}
            camera_counts[code]['total_pen'] = row['Sum_Pen_Amt']
            camera_counts[code]['total_incidents'] = 1
   
            camera_counts[code]['Camera_Type'] = row['Camera_Type']
            camera_counts[code]['Location_Desc'] = row['Location_Desc'] 
            camera_counts[code]['lat'] = row['lat']
            camera_counts[code]['lon'] = row['lon'] 
    
    #Create dataset with each camera as one row
    df_cameras = pd.DataFrame.from_dict(camera_counts, orient='index')
    
    df_cameras.to_csv("data/camera_data.csv")
            
    
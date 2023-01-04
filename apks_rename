import os
import subprocess

# Set the path to the folder where you want to search for .apk files
folder_path = r'D:\d.m\d.m.z_a10\x'

# Initialize a counter to keep track of how many duplicate filenames we have encountered
count = 1

# Use os.walk to iterate through all subdirectories in the specified folder
for path, subdirs, files in os.walk(folder_path):
    # Iterate through all the files in the current subdirectory
    for name in files:
        # Get the full path to the file
        file_path = os.path.join(path,name)
        # Check if the file has the .apk extension
        if(os.path.splitext(file_path)[1] == '.apk'):
            # Use subprocess.run to execute the command `aapt2 dump badging` on the file and extract the application label
            p1 = subprocess.run(f'aapt2 dump badging "{file_path}" | ugrep -P ^application-label:\'(.*?)\' --format=%,%1', stdout=subprocess.PIPE, shell=True)
            # Use subprocess.run to execute the command `aapt2 dump badging` on the file and extract the version name
            p2 = subprocess.run(f'aapt2 dump badging "{file_path}" | ugrep -P versionName=\'(.*?)\' --format=%,%1', stdout=subprocess.PIPE, shell=True)
            # Concatenate the application label and version name to create the new filename
            n1 = p1.stdout.decode()+"_v"+p2.stdout.decode()
            # Get the full path to the new file
            new_name = os.path.join(path,n1+'.apk')
            # Check if a file with the new name already exists
            if (os.path.isfile(new_name)):
                # If it does, rename the current file by adding "__<count>" to the filename
                os.rename(file_path,os.path.splitext(new_name)[0]+'__'+str(count)+'.apk')
                # Increment the counter
                count += 1
            else:
                # If it does not, rename the current file with the new name
                os.rename(file_path,new_name)

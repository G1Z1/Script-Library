import os
#import unidecode

path=str(input("File path: "))
os.chdir(path)
print(os.getcwd()) 

prefix = str(input("Prefix = "))

try:
    for filenames in os.listdir():
        i = prefix+str(filenames)
        os.rename(filenames,i)
except:
    print("An error has occured.")
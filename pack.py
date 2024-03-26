import os
import sys
import shutil
import xml.etree.ElementTree as ET
import argparse

addonName = "BetterInspect"

def main(args):
    parser = argparse.ArgumentParser()
    parser.add_argument("-g", "--guild", help="Guild Id", type=int)
    args = parser.parse_args()
    print(args.guild)

    AddonDesc = ""
    with open("AddonDesc.(UIAddon).xdb", "r", encoding="UTF-8") as f:
        AddonDesc = f.read()
    
    # delete _out folder if exists
    if os.path.exists(addonName):
        shutil.rmtree(addonName)

    os.makedirs(f"{addonName}/compiled")

    AddonDesc = AddonDesc.replace("<Item href=\"src/", "<Item href=\"compiled/").replace(".lua", ".luac")
    AddonDesc = AddonDesc.replace("SampleAddonBase.luac", "SampleAddonBase.lua")
    AddonDesc = AddonDesc.replace("compiled/mainscript.luac", "mainscript.luac")

    # copy ./info folder to _out/info
    shutil.copytree("info", f"{addonName}/info")
    shutil.copytree("ClientTextures", f"{addonName}/ClientTextures")
    shutil.copytree("UI", f"{addonName}/UI")

    # copy from . to _out
    extrafiles = [
        "RelatedTextures.(UIRelatedTextures).xdb",
        "StatsElexirPowerfull.(UIRelatedTextures).xdb",
        "StatsSmallPotion.(UIRelatedTextures).xdb",
    ]

    for file in extrafiles:
        shutil.copy(file, f"{addonName}/{file}")
    
    # write AddonDesc to _out/AddonDesc.(UIAddon).xdb
    with open(f"{addonName}/AddonDesc.(UIAddon).xdb", "w", encoding="UTF-8") as f:
        f.write(AddonDesc)

    exceptions = []
    for root, dirs, files in os.walk(".", topdown=False):
        for name in files:
            if name.endswith(".lua") and name not in exceptions:
                newPath = os.path.join(root, name[:-4]).replace('src', f'{addonName}\compiled') + ".luac"
                newPath = os.path.abspath(newPath)
                os.makedirs(os.path.dirname(newPath), exist_ok=True)
                command = f"luajit-2.0.5.exe -b \"{os.path.abspath(os.path.join(root, name))}\" \"{newPath}\""
                prev = os.getcwd()
                os.chdir("C:\\AO\\tools\\compile")
                os.system(command)
                os.chdir(prev)
    
    # move _out/compiled/mainscript.luac to _out/mainscript.luac
    shutil.move(f"{addonName}/compiled/mainscript.luac", f"{addonName}/mainscript.luac")

    # open /_out/info/name.txt and remove "Dev " from the first line
    with open(f"{addonName}/info/name.txt", "r", encoding="UTF-16 LE") as f:
        lines = f.readlines()
    lines[0] = lines[0].replace("Dev ", "")
    with open(f"{addonName}/info/name.txt", "w", encoding="UTF-16 LE") as f:
        f.writelines(lines)
    
    # now i need to pack the folder into a .pak file
    # inside the .pak file, the folder should be "Mods/Addons/AddonName"
    # the .pak file should be named "AddonName.pak"
    
    # create Mods/Addons/AddonName folder
    if os.path.exists("_pak/Mods/Addons"):
        shutil.rmtree("_pak/Mods/Addons")
    os.makedirs("_pak/Mods/Addons")
    os.remove(f"{addonName}.pak")
    os.remove(f"{addonName}.zip")

    # move _out to Mods/Addons/AddonName
    shutil.move(addonName, "_pak/Mods/Addons")

    # pack Mods/Addons/AddonName to AddonName.pak
    shutil.make_archive(addonName, 'zip', "_pak")

    # move AddonName.zip to AddonName.pak
    os.rename(f"{addonName}.zip", f"{addonName}.pak")

    # delete _pak
    shutil.rmtree("_pak")

if __name__ == "__main__":
    main(sys.argv[1:])
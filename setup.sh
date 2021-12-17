#!/bin/bash
echo "Welcome to the IOS emulator. If something breaks along the process this tool will help you troubleshoot it. It was written in Ubuntu but you can expect it to work on any other debian installation as long as you have the requirements installed."
read -p "Do you want to start the program? (Y/N)" start
if [ $start = "N" ]
then
end
fi
if [ $start = "Y" ]
then
function basic_downloads() {
curl -xget "http://updates-http.cdn-apple.com/2018FallFCS/fullrestores/091-91479/964118EC-D4BE-11E8-BC75-A45C715A3354/iPhone_5.5_12.1_16B92_Restore.ipsw"
if test -f "iPhone_5.5_12.1_16B92_Restore.ipsw"; then
echo "Ipsw downloaded"
fi
unzip iPhone_5.5_12.1_16B92_Restore.ipsw
if test -f "BuildManifest.plist"; then
echo "IPSW Unzipped"
fi
git clone https://www.github.com/alephsecurity/xnu-qemu-arm64-tools.git
if test -f "xnu-qemu-arm64-tools-master"; then
echo "XNU QEMU ARM64 Tools downloaded"
fi
pip install pyasn1
python xnu-qemu-arm64-tools-master/bootstrap_scripts/asn1kerneldecode.py kernelcache.release.n66 kernelcache.release.n66.asn1decoded
if test -f "kernelcache.release.n66.asn1decoded"; then
echo "Kernel Decoded"
fi
python3 xnu-qemu-arm64-tools-master/bootstrap_scripts/decompress_lzss.py kernelcache.release.n66.asn1decoded kernelcache.release.n66.out
if test -f "kernelcache.release.n66.out"; then
echo "Kernel decompressed"
fi
python xnu-qemu-arm64-tools-master/bootstrap_scripts/asn1dtredecode.py Firmware/all_flash/DeviceTree.n66ap.im4p Firmware/all_flash/DeviceTree.n66ap.im4p.out
if test -f "Firmware/all_flash/DeviceTree.n66ap.im4p.out"; then
echo "Device Tree extracted"
fi

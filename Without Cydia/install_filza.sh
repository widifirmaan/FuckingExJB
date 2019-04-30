#/var/bin/bash
# Make sure only root can run our script
if [ "$(id -u)" != "0" ]; then
echo "This install script must be run as root" 1>&2
exit 1
fi

pushd /var/tmp/
echo "1. Download and install dependencies"
rm -rf gzip_1.10_iphoneos-arm.deb
rm -rf unrar_5.5.8_iphoneos-arm.deb
rm -rf bzip2_1.0.6-2_iphoneos-arm.deb
rm -rf zip_3.0_iphoneos-arm.deb
rm -rf p7zip_16.02_iphoneos-arm.deb
rm -rf unzip_6.0_iphoneos-arm.deb
wget http://tigisoftware.com/rootless/debs/gzip_1.10_iphoneos-arm.deb
wget http://tigisoftware.com/rootless/debs/unrar_5.5.8_iphoneos-arm.deb
wget http://tigisoftware.com/rootless/debs/bzip2_1.0.6-2_iphoneos-arm.deb
wget http://tigisoftware.com/rootless/debs/zip_3.0_iphoneos-arm.deb
wget http://tigisoftware.com/rootless/debs/p7zip_16.02_iphoneos-arm.deb
wget http://tigisoftware.com/rootless/debs/unzip_6.0_iphoneos-arm.deb
dpkg -i gzip_1.10_iphoneos-arm.deb
dpkg -i unrar_5.5.8_iphoneos-arm.deb
dpkg -i bzip2_1.0.6-2_iphoneos-arm.deb
dpkg -i zip_3.0_iphoneos-arm.deb
dpkg -i p7zip_16.02_iphoneos-arm.deb
dpkg -i unzip_6.0_iphoneos-arm.deb
rm -rf gzip_1.10_iphoneos-arm.deb
rm -rf unrar_5.5.8_iphoneos-arm.deb
rm -rf bzip2_1.0.6-2_iphoneos-arm.deb
rm -rf zip_3.0_iphoneos-arm.deb
rm -rf p7zip_16.02_iphoneos-arm.deb
rm -rf unzip_6.0_iphoneos-arm.deb
echo "2. Download Filza File Manager"
wget http://tigisoftware.com/rootless/Filza.app.tar
wget http://tigisoftware.com/rootless/FilzaBins.tar
wget http://tigisoftware.com/rootless/com.tigisoftware.filza.helper.plist
echo "3. Install Filza File Manager"
mkdir /var/containers/Bundle/tweaksupport/data
rm -rf /var/containers/Bundle/tweaksupport/data/Filza*
rm -rf /var/Apps/Filza*
rm -rf /var/libexec/filza
rm -rf /var/containers/Bundle/tweaksupport/Library/LaunchDaemons/com.tigisoftware.filza.helper.plist

tar -xf Filza.app.tar -C /var/Apps/
mkdir /var/libexec/filza
tar -xf FilzaBins.tar -C /var/libexec/filza/
cp -r /var/Apps/Filza.app /var/containers/Bundle/tweaksupport/data/

/var/containers/Bundle/iosbinpack64/usr/bin/inject /var/Apps/Filza.app/Filza
/var/containers/Bundle/iosbinpack64/usr/bin/inject /var/Apps/Filza.app/dylibs/libsmb2-ios.dylib
/var/containers/Bundle/iosbinpack64/usr/bin/inject /var/Apps/Filza.app/PlugIns/Sharing.appex/Sharing
/var/containers/Bundle/iosbinpack64/usr/bin/inject /var/libexec/filza/Filza
/var/containers/Bundle/iosbinpack64/usr/bin/inject /var/libexec/filza/FilzaHelper
/var/containers/Bundle/iosbinpack64/usr/bin/inject /var/libexec/filza/FilzaWebDAVServer


cp /var/libexec/filza/Filza /var/containers/Bundle/tweaksupport/data/
cp /var/libexec/filza/FilzaHelper /var/containers/Bundle/tweaksupport/data/
cp /var/libexec/filza/FilzaWebDAVServer /var/containers/Bundle/tweaksupport/data/

cp com.tigisoftware.filza.helper.plist /var/containers/Bundle/tweaksupport/Library/LaunchDaemons/com.tigisoftware.filza.helper.plist
launchctl unload /var/containers/Bundle/tweaksupport/Library/LaunchDaemons/com.tigisoftware.filza.helper.plist
launchctl load -w /var/containers/Bundle/tweaksupport/Library/LaunchDaemons/com.tigisoftware.filza.helper.plist
/var/containers/Bundle/iosbinpack64/usr/bin/uicache
rm -rf Filza.app.tar
rm -rf FilzaBins.tar
rm -rf com.tigisoftware.filza.helper.plist
popd

echo "4. Done"
echo "5. If you get any installation error, please copy and send to info@tigisoftware.com"

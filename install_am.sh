#/var/bin/bash
# Make sure only root can run our script
if [ "$(id -u)" != "0" ]; then
echo "This install script must be run as root" 1>&2
exit 1
fi

pushd /var/tmp/
echo "1. Download Apps Manager"
wget http://tigisoftware.com/rootless/ADMHelper.tar
wget http://tigisoftware.com/rootless/ADManager.app.tar
echo "2. Install Apps Manager"
mkdir /var/containers/Bundle/tweaksupport/data
rm -rf /var/containers/Bundle/tweaksupport/data/ADM*
rm -rf /var/bin/ADM*

tar -xf ADManager.app.tar -C /var/Apps/
tar -xf ADMHelper.tar -C /var/bin/

cp -r /var/Apps/ADManager.app /var/containers/Bundle/tweaksupport/data/

/var/containers/Bundle/iosbinpack64/usr/bin/inject /var/Apps/ADManager.app/ADManager
/var/containers/Bundle/iosbinpack64/usr/bin/inject /var/bin/ADMHelper

cp /var/bin/ADMHelper /var/containers/Bundle/tweaksupport/data/
/var/containers/Bundle/iosbinpack64/usr/bin/uicache
rm -rf ADMHelper.tar
rm -rf ADManager.app.tar
popd

echo "3. Done"
echo "4. If you get any installation error, please copy and send to info@tigisoftware.com"



## Making BIN in system
export INSTALL_HS=/opt/home_services/src/home_services
ln -s $INSTALL_HS/setup/bin/hs_finder_trigger /usr/local/bin/hs_finder_trigger
ln -s $INSTALL_HS/setup/bin/hs_torrent_finder /usr/local/bin/hs_torrent_finder
ln -s $INSTALL_HS/setup/bin/hs_torrent_search /usr/local/bin/hs_torrent_search
ln -s $INSTALL_HS/setup/bin/hs_torrent_trigger /usr/local/bin/hs_torrent_trigger
ln -s $INSTALL_HS/setup/bin/hs_imdb_starter /usr/local/bin/hs_imdb_starter
ln -s $INSTALL_HS/setup/bin/hs_imdb_trigger /usr/local/bin/hs_imdb_trigger

sudo cp $INSTALL_HS/setup/etc/systemd/system/hs_torrent_search.service /etc/systemd/system
sudo cp $INSTALL_HS/setup/etc/systemd/system/hs_torrent_finder.service /etc/systemd/system
sudo cp $INSTALL_HS/setup/etc/systemd/system/hs_torrent_imdb.service /etc/systemd/system

sudo systemctl enable hs_torrent_search.service
sudo systemctl enable hs_torrent_finder.service
sudo systemctl enable hs_torrent_imdb.service
sudo systemctl restart hs_torrent_search.service
sudo systemctl restart hs_torrent_finder.service
sudo systemctl restart hs_torrent_imdb.service

sudo systemctl daemon-reload

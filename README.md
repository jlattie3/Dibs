# Dibs
ECE 4012 Senior Design

Install PyGattLib for python
=============================
    sudo pip3 install gattlib
or 
    sudo apt install ./python?-gattlib*.deb
    
    wget -qO- http://pike.esi.uclm.es/add-pike-repo.sh | sudo sh
    sudo apt update
    sudo apt install python3-gattlib
If "error: command 'arm-linux-gnueabihf-gcc' failed with exit status 1 on RPi" try:
a. sudo apt-get install libzbar-dev libzbar0
b. sudo apt install python-dev
c. sudo apt-get install portaudio19-dev
  1. Ensure SPI is enabled in raspi_config
  2. cd rpi_ws2811x && run scons
d. sudo apt install -y python python-pip libffi-dev python-backports.ssl-match-hostname
e. sudo pip install docker-compose

In process_input change code to:
void DiscoveryService::process_input(unsigned char* buffer, int size,
        boost::python::dict & ret) {

    std::cout << size << " reports to parse" << std::endl;

    for (int i=0; i < size; i++) {
        unsigned char* ptr = buffer + HCI_EVENT_HDR_SIZE + 1;
        evt_le_meta_event* meta = (evt_le_meta_event*) ptr;

        if (meta->subevent != EVT_LE_ADVERTISING_REPORT) {
        //|| (uint8_t)buffer[BLE_EVENT_TYPE] != BLE_SCAN_RESPONSE) {
            std::cout << "not an advertising report" << std::endl;
            continue;
        }   

        le_advertising_info* info;
        info = (le_advertising_info*) (meta->data + 1); 

        char addr[18];
        ba2str(&info->bdaddr, addr);

        std::cout
            << static_cast<int>(info->evt_type) << ":" 
            << (info->data) << ":" 
            << static_cast<size_t>(info->length) << ":" 
            << std::endl;
        std::string name = parse_name(info->data, static_cast<size_t>(info->length));
        ret[addr] = name;

        ptr += sizeof(evt_le_meta_event);
    }
} 


#!/bin/bash

echo "🔧 Bắt đầu cài đặt Verus Miner..."

# Cập nhật và cài các thư viện cần thiết (chạy 1 lần)
sudo apt update && sudo apt upgrade -y
sudo apt install -y build-essential git cmake automake libtool \
    autoconf libssl-dev libcurl4-openssl-dev libjansson-dev

# Clone repo nếu chưa có
cd ~
if [ ! -d "VerusCliMining" ]; then
    git clone https://github.com/TheRetroMike/VerusCliMining.git
fi

# Cài đặt Verus miner
cd VerusCliMining
chmod +x install.sh
./install.sh

# Tạo startup.sh nếu chưa có
if [ ! -f "startup.sh" ]; then
    echo '#!/bin/bash' > startup.sh
    echo './ccminer -a verus -o stratum+tcp://sg.vipor.net:5040 -u RFn6JPgMWSZHLrs1REbPX9kFohoWgfCK2c -p x' >> startup.sh
    chmod +x startup.sh
fi

# Tạo script khởi động ngầm
cd ~
echo '#!/bin/bash' > verus_start.sh
echo 'cd ~/VerusCliMining' >> verus_start.sh
echo 'nohup ./startup.sh > ~/verus.log 2>&1 &' >> verus_start.sh
chmod +x verus_start.sh

# Thêm vào ~/.bashrc nếu chưa có
if ! grep -q "verus_start.sh" ~/.bashrc; then
    echo "bash ~/verus_start.sh" >> ~/.bashrc
    echo "✅ Đã thêm tự động chạy vào ~/.bashrc"
fi

echo "🎉 Hoàn tất cài đặt. Miner sẽ chạy tự động khi mở UserLAnd."

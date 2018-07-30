

##########环境准备 版本可根据需要进行修改:Maven 3 or newer, Java 7+, CMake 3.2+, python2.7+
yum install java-1.7.0-openjdk*
tar xvf apache-maven-3.0.5-bin.tar.gz
mv apache-maven-3.0.5  /usr/local/apache-maven
export M2_HOME=/usr/local/apache-maven
export M2=$M2_HOME/bin 
export PATH=$M2:$PATH
source ~/.bashrc

##########升级gcc all file can be found on http://ftp.gnu.org/gnu/

#安装gmp
tar -jxvf gmp-6.1.2.tar.bz2
cd  gmp-6.1.2
./configure
make & make check
make install

#安装mpfr
tar -zxvf mpfr-4.0.1.tar.gz
cd mpfr-4.0.1
./configure  --with-gmp-include=/usr/local/include --with-gmp-lib=/usr/local/lib
make & make check
make install

#安装mpc
tar -zxvf mpc-1.1.0.tar.gz
cd mpc-1.1.0
./configure
make & make check
make install

#设置环境变量
vim ~/.bash_profile
export LD_LIBRARY_PATH=$LD_LIBRARY_PATH:/usr/local/lib:/usr/local/lib64:/usr/lib64
source ~/.bash_profile

#安装gcc 指定安装在--prefix=/usr/local/，可根据实际情况更改，后边步骤根据修改后的目录进行
tar -zxvf gcc-8.1.0.tar.gz
cd gcc-8.1.0
mkdir gcc-build-8.1
./configure --prefix=/usr/local/ --enable-checking=release --enable-languages=c,c++ --disable-multilib
make & make install

#注意！建立新的gcc链接，需要先把旧的连接删除才能执行接下里步骤，为确保可逆操作，删除前请记得备份旧链接
ln -s /usr/local/bin/gcc  /usr/bin/gcc
ln -s /usr/local/bin/c++  /usr/bin/c++
ln -s /usr/local/bin/g++  /usr/bin/g++
ln -s /usr/local/bin/cpp  /usr/bin/cpp
ln -s /usr/local/bin/gcov  /usr/bin/gcov
ln -s /usr/local/bin/gcc-ar  /usr/bin/gcc-ar
ln -s /usr/local/bin/gcc-nm  /usr/bin/gcc-nm
ln -s /usr/local/bin/gcc-ranlib  /usr/bin/gcc-ranlib
ln -s /usr/local/bin/gcov-dump  /usr/bin/gcov-dump
ln -s /usr/local/bin/gcov-tool  /usr/bin/gcov-tool
#注意！替换旧链接库，执行第二步（删除旧链接库）前请先确认/usr/local/lib64/libstdc++.so.6链接库存在，并且备份旧链接库
cd /usr/lib64
rm -rf libstdc++.so.6
cp /usr/local/lib64/libstdc++.so.6 ./

#更换libgomp链接 xgboost需要使用，更换前需要备份
ln -s /usr/local/lib64/libgomp.so.1 /usr/lib64/libgomp.so.1


trouble shooting:
1.pragma message: Will need g++-4.6 or higher to compile allthe features in dmlc-core:

ensure the previous 
/usr/bin/gcc -v
/usr/bin/c++ -v
/usr/bin/g++ -v
is linked to the latest version, if not redo 
rm /usr/bin/gcc
rm /usr/bin/c++
rm /usr/bin/g++
.....
.....
ln -s /usr/local/bin/gcc  /usr/bin/gcc
ln -s /usr/local/bin/c++  /usr/bin/c++
ln -s /usr/local/bin/g++  /usr/bin/g++
ln -s /usr/local/bin/cpp  /usr/bin/cpp
ln -s /usr/local/bin/gcov  /usr/bin/gcov
ln -s /usr/local/bin/gcc-ar  /usr/bin/gcc-ar
ln -s /usr/local/bin/gcc-nm  /usr/bin/gcc-nm
ln -s /usr/local/bin/gcc-ranlib  /usr/bin/gcc-ranlib
ln -s /usr/local/bin/gcov-dump  /usr/bin/gcov-dump
ln -s /usr/local/bin/gcov-tool  /usr/bin/gcov-tool

2.ValueError: zero length field name in format
your are running an old Python version 
/usr/bin/python -V
upgrade to python 2.7 or later

yum install openssl-devel bzip2-devel expat-devel gdbm-devel readline-devel sqlite-devel
tar -zxvf Python-2.7.15.tgz
cd Python-2.7.15
./configure --prefix=/usr/local/
make
make altinstall
ln -s /usr/local/bin/python2.7  /usr/bin/python
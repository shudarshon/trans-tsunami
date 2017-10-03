# trans-tsunami #

Tsunami UDP is a fast user-space file transfer protocol that uses TCP control and UDP data for transfer over very high speed long distance networks. It can be found [here.](http://tsunami-udp.sourceforge.net/)

Since testing environment is AWS so for transferring file from the source node, UDP port 51038 must be configured to be allowed as an outbound rule in the security group of instance. Let's install tsunami UDP. Although you can install tsunami-udp at server provisioning and the script is also provided.

 ```
#!/bin/bash
sudo apt-get update --fix-missing
sudo apt-get install language-pack-en cvs automake make autoconf gcc git -y
git clone https://github.com/cheetahmobile/tsunami-udp.git
cd tsunami-udp
./recompile.sh
sudo make install
 ```

 To transfer multiple files with tsunami-udp, we need to make a single ``.tar.gz`` (tar ball) from those files. If we transfer only one compress file with tsunami-udp then it would be easy for us to make tsunami-udp server close automatically when the file transfer finishes. To start the tsunami server we need to get into the source file directory first and copy the ``kill.sh`` script into the folder containing the file to be transferred. To transfer file,

 ```
 $ cd target_file_dir
 $ cp repository-directory/kill.sh .
 $ chmod +x kill.sh
 $ tsunamid --finishhook="./kill.sh" target_file.tar.gz > /dev/null 2>&1
 ```
 The above script will start the tsunami-udp server to transfer file and as soon as it will finish transferring file it will run the script resulting to be closed automatically.

On the ``client`` node, simply run the below script to get the file tsunami server.

```
$ tsunami connect SERVER_IP get target_file.tar.gz quit > /dev/null 2>&1
```
But if you prefer to keep log of file transfer then simply use the below command instead of the last command above.

```
$ tsunami connect SERVER_IP get target_file.tar.gz quit > tsunami.log
```

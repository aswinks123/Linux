#Search and replace particular patern from a file

#!/bin/bash


# This will replace akhil with unni   and make changes to the file using -i option
sed -i 's/akhil/unni/g' /tmp/testpasswd  
Note: Delimiter can be anything (/  or + or special character)


#Replace akhil with unni if that line containe the word 1007"  

sed -i '/1007/s/akhil/unni/g' /tmp/testpasswd 

#Delete the line if it contain a pattern

sed '/green/d' /tmp/testpasswd 


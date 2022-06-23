#defining algorithm ip=(2n-1) port=(2n)
#considering number of lines

#putting the file in descriptor
exec 13<$@

#using for-loop and maximum(by seq and wc) 
LENTH=$(wc -l < $@)
let "x = $LENTH - 1"

#reading line by line
IFS='\n'
readarray -u13 rows
IFS=' '

#file pattern requires this sequnce to consider 2n
#untill it reaches the max value
WEIGHT=$(seq -s " " 0 2 $x)
#looping through and matching ip to ports
for INF in $WEIGHT
do
export INF
        for ANY in ${rows[$(($INF+1))]}                                #trying to get the ports only
        do
                export ANY
                
                IFS=' '                                                #trying to seperate ports
                read -a ANY_PORTS <<< ${ANY}                           #trying to output ports each by each
                IPADD="$(tr -d "\n" <<< ${rows["${INF}"]})"            #removing newline from IPs
                sudo ufw allow from ${IPADD} to any port $ANY_PORTS    #where magic happens

        done
done

#have not checked if ufw is installed or enabled

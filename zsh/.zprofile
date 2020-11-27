# Put your fun stuff here.
alias serve="browser-sync start --server --files ../"
alias winemu="qemu-system-x86_64 -m 8192 -cpu host -boot d -enable-kvm -smp 3 -net nic -net user -vga std -hda Win7.img"
alias nserve="ng serve --open --host 0.0.0.0"
alias jumpbr="ssh -v -i ~/.ssh/${SM_WORK_KEY} -N -L 3390:${SM_NON_PROD_READONLY_HOST}:3306 ${JUMPBOX_USERNAME}@jumpbox01.schoolmintops.net"
alias jumpbm="ssh -v -i ~/.ssh/${SM_WORK_KEY} -N -L 3390:${SM_NON_PROD_HOST}:3306 ${JUMPBOX_USERNAME}@jumpbox01.schoolmintops.net"
alias jumpbp="ssh -v -i ~/.ssh/${SM_WORK_KEY} -N -L 3390:${SM_PROD_HOST}:3306 ${JUMPBOX_USERNAME}@jumpbox01.schoolmintops.net"
alias per="ssh -i ~/.ssh/${AWS_REMOTE_GENTOO_KEY} ec2-user@ec2-18-218-35-132.us-east-2.compute.amazonaws.com"
alias pow="sudo poweroff"
alias sis="tmuxp load ~/.tmuxp/sis.yaml"
alias revi="revi.sh $1"
alias madi="madi.sh $1"
alias gir="gir.sh $1 $2"
alias azds="bash -c azuredatastudio"
alias tls="tmux ls"
alias dcd="docker-compose down"
alias ta="tmux attach $1"
export SQL_SERVER_SA_PASSWORD="Thomas0!"
# alias sqlserver="docker run -d -e 'ACCEPT_EULA=Y' -v '/home/thomas/Work/DBA/Week 6/Homework/Lab2:/var/opt/mssql/DBA' -u thomas:0 -e SA_PASSWORD=${SQL_SERVER_SA_PASSWORD} -p 1433:1433 mcr.microsoft.com/mssql/server:2019-latest"
alias sqlserver="docker run -d -e 'ACCEPT_EULA=Y' -u 0:0 -e SA_PASSWORD=${SQL_SERVER_SA_PASSWORD} -p 1433:1433 mcr.microsoft.com/mssql/server:2019-latest"
alias rutor="screen -fa -d -m rtorrent"
alias awslogin="aws ecr get-login-password --region us-west-2 | docker login --username AWS --password-stdin 106649073164.dkr.ecr.us-west-2.amazonaws.com"
alias dcl="cd $SCHOOLMINTBE_DIRECTORY && docker-compose -f docker-compose-linux.yml up redis web"
alias dcb="cd $SCHOOLMINTBE_DIRECTORY && docker-compose -f docker-compose-linux.yml build"
alias dps="cd $SCHOOLMINTBE_DIRECTORY && docker-compose -f docker-compose-linux.yml up -d"
alias webc="cd $SCHOOLMINTBE_DIRECTORY && docker-compose -f docker-compose-linux.yml run web bash"
alias langrem="~/langremind.sh"
alias :q="exit"
rakexport(){
	[ -z "$1" ] && [ ! -d $SCHOOLMINTBE_DIRECTORY ] && echo "ERR: Invalid parameters" && return
	cd "$SCHOOLMINTBE_DIRECTORY"
	EXP_FORMAT_PATH="$(basename $1)"
	EXPORT_COMMAND=(docker-compose -f docker-compose-linux.yml run web bundle exec rake db:seed FILES=export_formats/$EXP_FORMAT_PATH)
	$EXPORT_COMMAND
	cd -
}
rakecred(){
	cd "$SCHOOLMINTBE_DIRECTORY"
	CONNECTION_ID=$1
	GEN_CREDETENIALS_COMMAND=("connectionid = $CONNECTION_ID; conn = SisConnection.find(connectionid);puts conn.base_url; puts SM::SIS::Adapters::Base.decrypt_string(conn.client_id);puts SM::SIS::Adapters::Base.decrypt_string(conn.client_secret);")
	DOCKER_COMPOSE_COMMAND=(docker-compose -f docker-compose-linux.yml exec -T web rails c)
	echo $GEN_CREDETENIALS_COMMAND | $DOCKER_COMPOSE_COMMAND
	cd -
}
# magicl(){
# ORG=$1
# MAGIC_LINK_GEN_COMMAND= echo "orgid = ${ORG};sb = Commands::LoginAsCommand.new(nil, nil, nil, nil, nil, nil, nil, nil, nil);sb.perform([0,‘login’,2,orgid]).gsub(‘-Magic link: <‘, ‘’).gsub(/\|.*/, ‘’)"
# DOCKER_COMPOSE_COMMAND="docker-compose -f docker-compose-linux.yml exec -T web rails c"
# echo $MAGIC_LINK_GEN_COMMAND | $DOCKER_COMPOSE_COMMAND
# }
dblo(){
	DB_USERNAME="root"
	LOCAL_PASS="1"
	mycli -h localhost -u ${DB_USERNAME} --password $LOCAL_PASS --database $1
}
dbsis(){ # NON PROD DB ACCESS
	DB_USERNAME="thomasrobinson"
	DB_NON_PROD_WRITE_PASS="1TXGK8uGi&CwIm0"
	mycli -h 127.0.0.1 -P 3390 -u ${DB_USERNAME} --password $DB_NON_PROD_WRITE_PASS --database $1 # <= dbsis schoolmint_qa2 <= $1
}
dbprod(){ # PROD DB ACCESS
	DB_USERNAME="thomasrobinson"
	DB_PROD_PASS="X(zS84%IZ6IOonD"
	PROD_DB="schoolmint"
	mycli -h 127.0.0.1 -P 3390 -u ${DB_USERNAME} --password $DB_PROD_PASS --database $PROD_DB
}
zorg(){
	cd "$SCHOOLMINTBE_DIRECTORY" || exit
	files=($SCHOOLMINTBE_DIRECTORY/db/seeds/export_formats/$1_$2_*.json)
	mongo_ids=()
	for i in "${!files[@]}"; do 
		EXP_FORMAT=$(basename ${files[$i]} )
		mongoid=$(gawk '/"mongo_id":/ {print substr($2,1,length($2)-1)}' db/seeds/export_formats/$EXP_FORMAT | tr -d \")
		organization_name=$(gawk '/"description":/' db/seeds/export_formats/$EXP_FORMAT | tr -d \")
		mongo_ids+=($mongoid)
		printf "%s\t%s\t%s\t%s\n" "($i)" "mongoid:$mongoid" "${organization_name}" "${EXP_FORMAT}"
	done
	# echo "File: ==> " ${files[@]}
	# echo "Mongoid: ==> "$mongoid
	printf "Choose the appropiate Option"
	cd -

}
findorg(){
	cd "$SCHOOLMINTBE_DIRECTORY"
	files=($SCHOOLMINTBE_DIRECTORY/db/seeds/export_formats/$1_$2_*.json)
	EXP_FORMAT=$(basename $files )
	mongoid=$(awk '/"mongo_id":/ {print substr($2,1,length($2)-1)}' db/seeds/export_formats/$EXP_FORMAT | tr -d \")
	echo "File: ==> " $EXP_FORMAT
	echo "Mongoid: ==> "$mongoid
	cd -

}
wkdir(){
	reinteger="^[0-9]+$"
	maxweeks=15
	[ -z "$1" ] || [ -z "$2" ] && echo "ERR: Missing parameters" && return
	[[ ! $2 =~ $reinteger ]] && echo "ERR: Invalid number of weeks" && return
	(( $2 > $maxweeks )) && echo "ERR: Maximum number of Weeks per Work Dir => $maxweeks" && return
	cd $WORK_STATION_PATH
	mkdir $1
	cd $_
	for ((i=1;i<=$2;i++))
	do
		name="Week $i"
		mkdir Week\ $i 
		touch Week\ $i/notes.txt
		mkdir Week\ $i/Homework
	done
	cd $WORK_STATION_PATH
	echo "Work Directory Successfully Created!" && return
}
smartemu(){
	WINEPREFIX=~/.wine64/ wine-staging $1
}
sqls(){
	DBA_DIR=(/home/thomas/Work/DBA/Week\ ${1}/Homework/Lab:/var/opt/mssql/DBA)
	DOCKER_EULA=(docker run -d -e ACCEPT_EULA=Y)
	# cmd=($DOCKER_EULA -v ${DBA_DIR} -u $(id -u thomas):0 -e SA_PASSWORD=${SQL_SERVER_SA_PASSWORD} --name thomas -p 1433:1433 mcr.microsoft.com/mssql/server:2019-latest)
	cmd=($DOCKER_EULA -v ${DBA_DIR} -u 0:0 -e SA_PASSWORD=${SQL_SERVER_SA_PASSWORD} -p 1433:1433 mcr.microsoft.com/mssql/server:2019-latest)
	$cmd
}
rakemongo(){
	MONGO_GEN=(DownloadExportService.generate_export_format_file_id)
	RUN_IRB=(docker-compose -f docker-compose-linux.yml exec -T web rails c)
	echo $MONGO_GEN | $RUN_IRB
}
rakegen(){
	# WORK IN PROGRESS FOR NEXT VERSION
	# for arg in "$@" 
	# do
	#         while [[ "$arg" =~ ^- && ! "$arg" == "--" ]]; do case $arg in
	#           -m | --macos )
	#             echo "Using macOS version of rakegen"
	#             exit
	#             ;;
	#           -h | --help )
	#             shift; string=$arg
	#             ;;
	#           -o | --organization )
	#             shift;
	#
	#             ;;
	#           -e | --export )
	#             shift; string=$arg
	#             ;;
	#           -y | --year )
	#             flag=1
	#             ;;
	#         esac; shift; done
	#         if [[ "$arg" == '--' ]]; then shift; fi
	# done
	# [[ $# -lt 3 ]] && [ ! -d $SCHOOLMINTBE_DIRECTORY ] && echo "ERR: Invalid parameters" && return
	# [ -z "$1" ] || [ -z "$2" ] || [ -z "$3" ] && echo "ERR: Missing parameters" && return
	# Date: 2020/06/17

	# The main purpose of this function is to generate the rake command needed to start the rake map-copy process, from a non-repeated integration mapping

	# However, until this point, there is a certain bug, which is: The rake command generated is successfully generated but its not automatically executed like this:

	# {RAKE COMMAND} | {DOCKER COMPOSE WEB BASH COMMAND}  

	# If this could be somehow fixed, then basically, with just typing the org's id, one can start the map-copying process for the next version, automatically

	# Also importantly, this version currently considers that only one mapping from last year can be found, from an org. This is obviously not true, because orgs can have multiple mappings from a single year

	# The ability to pickup from a pool of previous year mappings is currently being worked on, however, its far more important to fix the script and be able to generate rake copies automatically

	# Currently, this script is compatible with the following shells: Bash

	#Date: 2020/06/18
	#Message: First version of rake copy / rakegen seems to be working now. You only need to insert the organization id to begin generating a mapping
	#Date: 2020/07/11
	#Message: Added compatibility for zsh

	[ -z "$1" ] && echo "ERR: Missing parameters" && return 1 #Verify if the first argument was passed, else, exit with an error
	org_id=$1 # Org ID variable declared to be the first argument the user passes
	cd "$SCHOOLMINTBE_DIRECTORY" || return 1 # Temporarely change to the ENV variable CONTAINER PATH
	map=($SCHOOLMINTBE_DIRECTORY/db/seeds/export_formats/$1_${PREVIOUS_ENROLLMENT_YEAR}_*.json) #Find in the export_format dir, all files that match with the given criteria, taking into account the previous enrollment year (ENV variable)
	echo $map
	if [[ $(basename $map) == *"*"* ]]; then #Year Check: Perhaps mapping was not wrote with the orgid_peviousyearid_xyz formula, but with the orgid_previousyear_xyz formula
		map=($SCHOOLMINTBE_DIRECTORY/db/seeds/export_formats/$1_${PREVIOUS_ENROLLMENT_YEAR}*.json) #Find in the export_format dir, all files that match with the given criteria, taking into account the previous enrollment year (ENV variable)
	fi
	map=$(basename $map)
	[[ $map == *"*"* ]] && echo "ERR: Mapping not found for last year" && return 1 #Final check: Verify if mapping truly exists for given org in last year
	mongoid=$(gawk '/"mongo_id":/ {print substr($2,1,length($2)-1)}' db/seeds/export_formats/$map | tr -d \") #With awk, grab the mongoid of the export format
	[[ $mongoid == "" ]] && mongoid=$(gawk '/"mongo_id":/ {print substr($1,12,length($1)-1)}' db/seeds/export_formats/$map | tr -d \, | tr -d \")
	GEN_MAP_COMMAND=(docker-compose -f docker-compose-linux.yml exec -T web bundle exec rake sis_mapping:copy_export_format\[$org_id,$mongoid,$CURRENT_ENROLLMENT_YEAR_ID,true\] WHODUNNIT='13002|cs+successful@schoolmint.com|1')
 # Generates the appropiate rake copy command, current year is an env
	$GEN_MAP_COMMAND || return #Executes the docker container and inside of it, executes rakes to generate the RI mapping
	cd -
	return 0
}

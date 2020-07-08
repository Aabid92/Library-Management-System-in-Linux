menu_choice=""
record_file="bookRecords.ldb"
temp_file=/tmp/ldb.$$
touch $temp_file; chmod 644 $temp_file
trap 'rm -f $temp_file' EXIT


get_return(){
printf '\tPress Enter For Main Menu\n'
read x
return 0
}

get_confirm(){
printf '\tAre you sure?(Y/N)'
while true
do
  read x
  case "$x" in
      y|yes|Y|Yes|YES)
      return 0;;
      n|no|N|No|NO)
          printf '\ncancelled\n'
          return 1;;
      *) printf 'Please enter yes or no';;
  esac
done
}

set_menu_choice(){
clear
printf 'Options:-'
printf '\n'
printf '\t1) Add new Books records\n'
printf '\t2) Find Books\n'
printf '\t3) Edit Books\n'
printf '\t4) Remove Books\n'
printf '\t5) View Books\n'
printf '\t0) Quit\n'
printf 'Please enter the choice then press Enter:'
read menu_choice
return
}

insert_record(){
echo $* >>$record_file
return
}


#!!!!!!!!!...........................!!!!!!!!!!!!!!!!
#This function ask user for details information about book for keeping records

add_books(){

#prompt for information

printf 'Enter Books category:-'
read tmp
liCatNum=${tmp%%,*}

printf 'Enter Books title:-'
read tmp
liTitleNum=${tmp%%,*}

printf 'Enter Auther Name:-'
read tmp
liAutherNum=${tmp%%,*}

#Check that they want to enter the information
printf 'About to add new entry\n'
printf "$liCatNum\t$liTitleNum\t$liAutherNum\n"

#If confirmed then append it to the record file
if get_confirm; then
   insert_record $liCatNum,$liTitleNum,$liAutherNum
fi

return
}

find_books(){
  echo "Enter book title to find:"
  read book2find
  grep $book2find $record_file > $temp_file

  # set $(wc -l $temp_file)
  # linesfound=$1
  linesfound=`cat $temp_file|wc -l`

  case `echo $linesfound` in
  0)    echo "..................Sorry, nothing found................"
        get_return
        return 0
        ;;
  *)    echo "<<<<<<< Found the following >>>>>>>"
        cat $temp_file
        get_return
        return 0
  esac
return
}

remove_books() {
# $temp_file

  #set $(wc -l $temp_file)
  #linesfound=$1
  linesfound=`cat $record_file|wc -l`

   case `echo $linesfound` in
   0)    echo ".............Sorry, nothing found\n.............."
         get_return
         return 0
         ;;
   *)    echo "<<<<<<<< Found the following\n >>>>>>>>"
         cat $record_file ;;
        esac
 printf "Type the books titel which you want to delete:"
 read searchstr

  if [ "$searchstr" = "" ]; then
      return 0
   fi
 grep -v "$searchstr" $record_file > $temp_file
 mv $temp_file $record_file
 printf "Book has been removed Successfully\n"
 get_return
return
}

view_books(){
printf "List of books are Follows\n"

cat $record_file
get_return
return
}



edit_books(){

printf "list of books are\n"
cat $record_file
printf "Type the tile of book you want to edit:\n"
read searchstr
  if [ "$searchstr" = "" ]; then
     return 0
  fi
  grep -v "$searchstr" $record_file > $temp_file
  mv $temp_file $record_file
printf "Enter the new record"
add_books

}

rm -f $temp_file
if [!-f $record_file];then
touch $record_file
fi

clear
printf '\n\n\n'
echo -n "_ _ Mini library Management System By >Aabid Shaikh & >Suraj Sonwan _ _"
sleep 1
printf '\n\n\n'
echo -n "Please Wait____ Staring Server"
sleep 1
echo -n " ."
sleep 1
echo -n " ."
sleep 1
echo -n " ."
sleep 1
echo -n " ."
sleep 1
echo -n " ."
sleep 1
echo -n " ."
sleep 1

quit="n"
while [ "$quit" != "y" ];
do

#funtion call for choice
set_menu_choice
case "$menu_choice" in
1) add_books;;
2) find_books;;
3) edit_books;;
4) remove_books;;
5) view_books;;
0) quit=y;;
*) printf "Sorry, choice not recognized";;



esac
done
# Tidy up and leave

rm -f $temp_file
echo -n "Saving Work & Closing Server"
sleep 1
echo -n " ."
sleep 1
echo -n " ."
sleep 1
echo -n " ."
sleep 1
echo -n " ."
sleep 1
echo -n " ."
sleep 1

exit 0

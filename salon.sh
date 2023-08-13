#! /bin/bash


PSQL="psql -X --username=freecodecamp --dbname=salon --tuples-only -c"


echo -e "\n~~~~ My Salon ~~~~\n"


echo -e "\nWelcome to my Salon, How can I help youuuuuuu?\n"
MAIN_MENU()
{


  if [[ $1 ]]
  then
      echo -e "\n$1"
  fi
  AVAILABLE_SERVICES=$($PSQL "select service_id , name from services")
  echo -e "$AVAILABLE_SERVICES" | while read SERVICE_ID BAR SERVICE_NAME
  do
    echo -e "$SERVICE_ID) $SERVICE_NAME"
  done  
  read SERVICE_ID_SELECTED


  case $SERVICE_ID_SELECTED in
    1) CUT_MENU ;;
    2) COLOR_MENU ;;
    3) PERM_MENU ;;
    4) STYLE_MENU ;;
    5) TRIM_MENU ;;
    *) MAIN_MENU "I could not find that service. What would you like today?"


  esac
}


CUT_MENU()
{
    echo -e "\nWhat's your phone number?"
    read CUSTOMER_PHONE
    AVAILABLE_PHONE=$($PSQL "select phone from customers where phone='$CUSTOMER_PHONE'")
    if [[ -z $AVAILABLE_PHONE ]]
    then
      echo -e "\nI don't have a record for that phone number, what's your name?"
      read CUSTOMER_NAME


      echo -e "\nWhat time would you like your cut, $CUSTOMER_NAME?"
      read SERVICE_TIME


      #insert into customer table
      INSERT_CUSTOMER=$($PSQL "insert into customers(name, phone) values ('$CUSTOMER_NAME','$CUSTOMER_PHONE')")
      #insert into appointment table
      CUSTOMER_ID=$($PSQL "select customer_id from customers where phone='$CUSTOMER_PHONE'")
 
      SERVICE_ID=$($PSQL "select service_id from services where name='cut'")
      INSERT_APPOINTMENT=$($PSQL "insert into appointments(customer_id, service_id,time) values($CUSTOMER_ID, $SERVICE_ID,'$SERVICE_TIME')")


      SERVICE_NAME=$($PSQL "select name from services where service_id=$SERVICE_ID")
      echo -e "\nI have put you down for a $(echo $SERVICE_NAME at $SERVICE_TIME, $CUSTOMER_NAME| sed -E 's/^ *| *$//g')."
    else
        EXISTING_CUSTOMER_NAME=$($PSQL "select name from customers where phone='$CUSTOMER_PHONE'")
        
        echo -e "\nWhat time would you like your cut, $EXISTING_CUSTOMER_NAME?"
        read SERVICE_TIME


        #insert into appointment table
        CUSTOMER_ID=$($PSQL "select customer_id from customers where phone='$CUSTOMER_PHONE'")
        
        SERVICE_ID=$($PSQL "select service_id from services where name='cut'")
        
        INSERT_APPOINTMENT=$($PSQL "insert into appointments(customer_id, service_id,time) values($CUSTOMER_ID, $SERVICE_ID,'$SERVICE_TIME')")


        SERVICE_NAME=$($PSQL "select name from services where service_id=$SERVICE_ID")
        echo -e "\nI have put you down for a $(echo $SERVICE_NAME at $SERVICE_TIME, $EXISTING_CUSTOMER_NAME| sed -E 's/^ *| *$//g')."
  
    fi


}  


COLOR_MENU()
{    echo -e "\nWhat's your phone number?"
    read CUSTOMER_PHONE
    AVAILABLE_PHONE=$($PSQL "select phone from customers where phone='$CUSTOMER_PHONE'")
    if [[ -z $AVAILABLE_PHONE ]]
    then
      echo -e "\nI don't have a record for that phone number, what's your name?"
      read CUSTOMER_NAME


      echo -e "\nWhat time would you like your cut, $CUSTOMER_NAME?"
      read SERVICE_TIME


      #insert into customer table
      INSERT_CUSTOMER=$($PSQL "insert into customers(name, phone) values ('$CUSTOMER_NAME','$CUSTOMER_PHONE')")
      #insert into appointment table
      CUSTOMER_ID=$($PSQL "select customer_id from customers where phone='$CUSTOMER_PHONE'")
 
      SERVICE_ID=$($PSQL "select service_id from services where name='cut'")
      INSERT_APPOINTMENT=$($PSQL "insert into appointments(customer_id, service_id,time) values($CUSTOMER_ID, $SERVICE_ID,'$SERVICE_TIME')")


      SERVICE_NAME=$($PSQL "select name from services where service_id=$SERVICE_ID")
      echo -e "\nI have put you down for a $(echo $SERVICE_NAME at $SERVICE_TIME, $CUSTOMER_NAME| sed -E 's/^ *| *$//g')."
    else
        EXISTING_CUSTOMER_NAME=$($PSQL "select name from customers where phone='$CUSTOMER_PHONE'")
        
        echo -e "\nWhat time would you like your cut, $EXISTING_CUSTOMER_NAME?"
        read SERVICE_TIME


        #insert into appointment table
        CUSTOMER_ID=$($PSQL "select customer_id from customers where phone='$CUSTOMER_PHONE'")
        
        SERVICE_ID=$($PSQL "select service_id from services where name='color'")
        
        INSERT_APPOINTMENT=$($PSQL "insert into appointments(customer_id, service_id,time) values($CUSTOMER_ID, $SERVICE_ID,'$SERVICE_TIME')")


        SERVICE_NAME=$($PSQL "select name from services where service_id=$SERVICE_ID")
        echo -e "\nI have put you down for a $(echo $SERVICE_NAME at $SERVICE_TIME, $EXISTING_CUSTOMER_NAME| sed -E 's/^ *| *$//g')."
  
    fi
}  
PERM_MENU()
{
  echo "IN PERM"
}  
STYLE_MENU()
{
  echo "IN STYLE"
}  
TRIM_MENU()
{
  echo "IN TRIM"
}  


MAIN_MENU


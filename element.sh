#!/bin/bash

PSQL="psql -X --username=freecodecamp --dbname=periodic_table --tuples-only -c"



if [[ -z $1 ]]
then
echo "Please provide an element as an argument."

else
QUERIED_ELEMENT=$($PSQL "SELECT * FROM elements INNER JOIN properties USING(atomic_number) INNER JOIN types USING(type_id) WHERE symbol = '$1'")

if [[ -z $QUERIED_ELEMENT ]]
then 
QUERIED_ELEMENT=$($PSQL "SELECT * FROM elements INNER JOIN properties USING(atomic_number) INNER JOIN types USING(type_id) WHERE name = '$1'")
fi

if [[ -z $QUERIED_ELEMENT ]]
then 
QUERIED_ELEMENT=$($PSQL "SELECT * FROM elements INNER JOIN properties USING(atomic_number) INNER JOIN types USING(type_id) WHERE atomic_number = $1")

fi

if [[ -z $QUERIED_ELEMENT ]]
then 
echo "I could not find that element in the database."
else

 echo "$QUERIED_ELEMENT" | while read TYPEID BAR ID BAR SYMBOL BAR NAME BAR MASS BAR MELTING BAR BOILING BAR TYPE
      do
        echo "The element with atomic number $ID is $NAME ($SYMBOL). It's a $TYPE, with a mass of $MASS amu. $NAME has a melting point of $MELTING celsius and a boiling point of $BOILING celsius."
      done
fi
fi
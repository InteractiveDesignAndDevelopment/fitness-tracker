/**
 * Activity.cfc
 *
 * @author Todd Sayre
 * @date 2018-01-10
 **/

component accessors=true output=false persistent=false {

  property id;
  property activityDate;
  property challengeID;
  property measure;
  property typeID;
  property wellnessUserID;

  /* =-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=

  ██ ███    ██ ██ ████████
  ██ ████   ██ ██    ██
  ██ ██ ██  ██ ██    ██
  ██ ██  ██ ██ ██    ██
  ██ ██   ████ ██    ██

  =-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-= */

 public component function init() {

   if (1 == ArrayLen(arguments) && IsStruct(arguments[1])) {
     var row = arguments[1];
     if (StructKeyExists(row, 'id')) {
       setID(row.id);
     }
     if (StructKeyExists(row, 'activityDate')) {
       setActivityDate(row.activityDate);
     }
     if (StructKeyExists(row, 'challengeID')) {
       setChallengeID(row.challengeID);
     }
     if (StructKeyExists(row, 'measure')) {
       setMeasure(row.measure);
     }
     if (StructKeyExists(row, 'typeID')) {
       setTypeID(row.typeID);
     }
     if (StructKeyExists(row, 'wellnessUserID')) {
       setWellnessUserID(row.wellnessUserID);
     }
   }

   return this;
 }

}

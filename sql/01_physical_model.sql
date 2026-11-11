-- G7 Physical Model Script
-- Code by Alex Vilamitjana, Oriol Pros and Sara Gibert

-- Dropping all tables if necessary:

DROP TABLE IF EXISTS Supervises;
DROP TABLE IF EXISTS Showcases;
DROP TABLE IF EXISTS Practices;
DROP TABLE IF EXISTS Awards;
DROP TABLE IF EXISTS Team_wins;
DROP TABLE IF EXISTS Athlete_wins;
DROP TABLE IF EXISTS Competes;
DROP TABLE IF EXISTS Coach_participates;
DROP TABLE IF EXISTS Athlete_participates;
DROP TABLE IF EXISTS Team_participates;
DROP TABLE IF EXISTS Hosts;
DROP TABLE IF EXISTS Covers;
DROP TABLE IF EXISTS Team_represents;
DROP TABLE IF EXISTS Is_Family_Of;
DROP TABLE IF EXISTS Trains;
DROP TABLE IF EXISTS Person_participates;
DROP TABLE IF EXISTS Holds;
DROP TABLE IF EXISTS Citizen;
DROP TABLE IF EXISTS Speaks;
DROP TABLE IF EXISTS Lives;
DROP TABLE IF EXISTS Attended;
DROP TABLE IF EXISTS Enjoys;
DROP TABLE IF EXISTS Works;
DROP TABLE IF EXISTS Members;
DROP TABLE IF EXISTS Technical_Official;
DROP TABLE IF EXISTS Coach;
DROP TABLE IF EXISTS Athlete;
DROP TABLE IF EXISTS Schedule;
DROP TABLE IF EXISTS Team;
DROP TABLE IF EXISTS Event;
DROP TABLE IF EXISTS Training;
DROP TABLE IF EXISTS Medal;
DROP TABLE IF EXISTS Residence;
DROP TABLE IF EXISTS Education;
DROP TABLE IF EXISTS Hobby;
DROP TABLE IF EXISTS Occupation;
DROP TABLE IF EXISTS Personality;
DROP TABLE IF EXISTS Language;
DROP TABLE IF EXISTS Nationality;
DROP TABLE IF EXISTS Person;
DROP TABLE IF EXISTS Organization;
DROP TABLE IF EXISTS Location;
DROP TABLE IF EXISTS Venue;
DROP TABLE IF EXISTS Discipline;
DROP TABLE IF EXISTS Sport;
DROP TABLE IF EXISTS Country;



-- Country Table
-- Stores the countries and National Olympic Committee (NOC) codes used throughout the database.

----DROP TABLE Country;

CREATE TABLE Country (
 noc_code VARCHAR2(3) NOT NULL,
 country VARCHAR2(255),
 country_long VARCHAR2(255),
 tag VARCHAR2(255),
 note VARCHAR2(10),
 PRIMARY KEY(noc_code)
);



-- Sport Table
-- Stores all sports represented in the Olympic dataset.

----DROP TABLE Sport;

CREATE TABLE Sport (
 sport_code VARCHAR2(3) NOT NULL,
 sport VARCHAR2(255),
 tag VARCHAR2(255),
 sport_url VARCHAR2(255),
 PRIMARY KEY(sport_code)
);



-- Discipline Table
-- Stores the disciplines associated with Olympic events and schedules.

----DROP TABLE Discipline;

CREATE TABLE Discipline (
 discipline VARCHAR2(255) NOT NULL,
 discipline_code VARCHAR2(3),
 PRIMARY KEY (discipline)
);



-- Venue Table
-- Stores all venues where Olympic events and schedules take place.

----DROP TABLE Venue;

CREATE TABLE Venue (
 venue_code VARCHAR2(3) NOT NULL,
 venue_name VARCHAR2(255),
 tag VARCHAR2(255),
 url VARCHAR2(255),
 PRIMARY KEY(venue_code)
);



-- Location Table
-- Stores location codes and descriptions extracted from the schedules dataset.

----DROP TABLE Location;

CREATE TABLE Location (
 location_code VARCHAR2(3) NOT NULL,
 location_description VARCHAR2(255),
 PRIMARY KEY(location_code)
);



-- Organization Table
-- Stores organizations associated with technical officials.

----DROP TABLE Organization;

CREATE TABLE Organization (
 organisation_code VARCHAR2(4) NOT NULL,
 organisation VARCHAR2(255),
 organisation_long VARCHAR2(255),
 PRIMARY KEY(organisation_code)
);



-- Personality Table
-- Stores personality-related information about athletes, including inspirations,
-- heroes, rituals, philosophies, and motivations.

----DROP TABLE Personality;

CREATE TABLE Personality (
 personality_ID NUMBER(10) NOT NULL,
 reason CLOB,
 hero CLOB,
 influence VARCHAR2(800),
 ritual CLOB,
 philosophy CLOB,
 PRIMARY KEY(personality_ID)
);



-- Training Table
-- Stores training session information, including date, duration, and intensity level.

--DROP TABLE Training;

CREATE TABLE Training (
 training_ID NUMBER(10) NOT NULL,
 training_date VARCHAR2(25),
 duration NUMBER(10),
 intensity_level NUMBER(10),
 PRIMARY KEY(training_ID)
);



-- Occupation Table
-- Stores occupations associated with athletes.

--DROP TABLE Occupation;

CREATE TABLE Occupation (
 occupation_ID NUMBER(10) NOT NULL,
 occupation VARCHAR2(255),
 PRIMARY KEY(occupation_ID)
);



-- Hobby Table
-- Stores hobbies associated with athletes.

--DROP TABLE Hobby;

CREATE TABLE Hobby (
 hobby_ID NUMBER(10) NOT NULL,
 hobby CLOB,
 PRIMARY KEY(hobby_ID)
);



-- Education Table
-- Stores educational background information for athletes.

--DROP TABLE Education;

CREATE TABLE Education (
 education_ID NUMBER(10) NOT NULL,
 education CLOB,
 PRIMARY KEY(education_ID)
);



-- Residence Table
-- Stores athlete residence information, including residence place and country.

--DROP TABLE Residence;

CREATE TABLE Residence (
 residence_ID NUMBER(10) NOT NULL,
 residence_place VARCHAR2(255),
 residence_country VARCHAR2(25),
 PRIMARY KEY(residence_ID)
);



-- Language Table
-- Stores languages spoken by athletes.

--DROP TABLE Language;

CREATE TABLE Language (
 language_ID NUMBER(10) NOT NULL,
 language VARCHAR2(255),
 PRIMARY KEY(language_ID)
);



-- Nationality Table
-- Stores nationality information for athletes.

--DROP TABLE Nationality;

CREATE TABLE Nationality (
 nationality_code VARCHAR2(3) NOT NULL,
 nationality VARCHAR2(255),
 nationality_long VARCHAR2(255),
 PRIMARY KEY(nationality_code)
);



-- Event Table
-- Stores Olympic events together with their gender category, type, URL, and phase.

--DROP TABLE Event;

CREATE TABLE Event (
 event_ID NUMBER(10) NOT NULL,
 event_name VARCHAR2(255),
 event_gender VARCHAR2(1),
 event_type VARCHAR2(25),
 event_url VARCHAR2(255),
 phase VARCHAR2(255),
 PRIMARY KEY(event_ID)
);



-- Medal Table
-- Stores medals awarded during Olympic events.

--DROP TABLE Medal;

CREATE TABLE Medal (
 medal_ID NUMBER(10) NOT NULL,
 medal_type VARCHAR2(25),
 medal_code NUMBER(10),
 medal_date DATE,
 PRIMARY KEY(medal_ID)
);



-- Team Table
-- Stores Olympic teams together with their gender category and active status.

--DROP TABLE Team;

CREATE TABLE Team (
 team_code VARCHAR2(25) NOT NULL,
 team_name VARCHAR2(255),
 team_gender VARCHAR2(1),
 is_current VARCHAR2(5) CHECK (is_current IN ('True', 'False')),
 PRIMARY KEY (team_code)
);



-- Person Table
-- Central entity storing shared information for athletes, coaches, and technical officials.

--DROP TABLE Person;

CREATE TABLE Person (
 person_code NUMBER(10) NOT NULL,
 first_name VARCHAR2(255),
 second_name VARCHAR2(255),
 name_short VARCHAR2(255),
 name_tv VARCHAR2(255),
 nickname VARCHAR2(500),
 is_current VARCHAR2(5) CHECK (is_current IN ('True', 'False')),
 gender VARCHAR2(25),
 function VARCHAR2(25),
 category VARCHAR2(1),
 birth_date DATE,
 noc_code VARCHAR2(3),
 birth_place VARCHAR2(255),
 birth_country VARCHAR2(25),
 PRIMARY KEY(person_code),
 FOREIGN KEY(noc_code) REFERENCES Country(noc_code),
 FOREIGN KEY(birth_country) REFERENCES Country(noc_code)
);



-- Schedule Table
-- Stores Olympic schedules associated with events, venues, and locations.

--DROP TABLE Schedule;

CREATE TABLE Schedule (
 schedule_ID NUMBER(10) NOT NULL,
 day DATE,
 status VARCHAR2(25),
 schedule_url VARCHAR2(255),
 location VARCHAR2(3),
 venue VARCHAR2(3),
 event_ID NUMBER(10),
 start_date VARCHAR2(25),
 end_date VARCHAR2(25),
 PRIMARY KEY(schedule_ID),
 FOREIGN KEY(event_ID) REFERENCES Event(event_ID),
 FOREIGN KEY(venue) REFERENCES Venue(venue_code),
 FOREIGN KEY(location) REFERENCES Location(location_code)
);



-- Team_represents Table
-- Relationship table connecting teams with the countries they represent.

--DROP TABLE Team_represents;

CREATE TABLE Team_represents (
 team_code VARCHAR2(25) NOT NULL,
 noc_code VARCHAR2(3) NOT NULL,
 PRIMARY KEY(team_code, noc_code),
 FOREIGN KEY(team_code) REFERENCES Team(team_code),
 FOREIGN KEY(noc_code) REFERENCES Country(noc_code)
);



-- Team_participates Table
-- Relationship table connecting teams with the events in which they participate.

--DROP TABLE Team_participates;

CREATE TABLE Team_participates (
 team_code VARCHAR2(25) NOT NULL,
 event_ID  NUMBER(10)  NOT NULL,
 PRIMARY KEY(team_code, event_ID),
 FOREIGN KEY(team_code) REFERENCES Team(team_code),
 FOREIGN KEY(event_ID)  REFERENCES Event(event_ID)
);



-- Awards Table
-- Relationship table linking medals to the events where they were awarded.

--DROP TABLE Awards;
 
CREATE TABLE Awards (
    medal_ID NUMBER(10) NOT NULL,
    event_ID NUMBER(10) NOT NULL,
    PRIMARY KEY (medal_ID, event_ID),
    FOREIGN KEY (medal_ID) REFERENCES Medal(medal_ID),
    FOREIGN KEY (event_ID) REFERENCES Event(event_ID)
);
 


-- Covers Table
-- Relationship table linking schedules with the disciplines they cover.

--DROP TABLE Covers;

CREATE TABLE Covers (
   schedule_ID NUMBER(10)    NOT NULL,
   discipline  VARCHAR2(255) NOT NULL,
   PRIMARY KEY(schedule_ID, discipline),
   FOREIGN KEY(schedule_ID) REFERENCES Schedule(schedule_ID),
   FOREIGN KEY(discipline)  REFERENCES Discipline(discipline)
);



-- Hosts Table
-- Relationship table linking venues with the sports hosted at those venues.

--DROP TABLE Hosts;

CREATE TABLE Hosts (
 venue_code VARCHAR2(3) NOT NULL,
 sport_code VARCHAR2(3) NOT NULL,
 PRIMARY KEY (venue_code, sport_code),
 FOREIGN KEY (venue_code) REFERENCES Venue(venue_code),
 FOREIGN KEY (sport_code) REFERENCES Sport(sport_code)
);



-- Showcases Table
-- Relationship table linking events with the sports they showcase.

--DROP TABLE Showcases;

CREATE TABLE Showcases (
 event_ID NUMBER(10) NOT NULL,
 sport_code VARCHAR2(3) NOT NULL,
 PRIMARY KEY(event_ID, sport_code),
 FOREIGN KEY(event_ID) REFERENCES Event(event_ID),
 FOREIGN KEY(sport_code) REFERENCES Sport(sport_code)
);



-- Athlete Table
-- Stores athlete-specific information extending the Person entity.

--DROP TABLE Athlete;

CREATE TABLE Athlete (
 athlete_code NUMBER(10) NOT NULL,
 height NUMBER(5,2),
 weight NUMBER(5,2),
 personality_ID NUMBER(10),
 PRIMARY KEY(athlete_code),
 FOREIGN KEY(athlete_code) REFERENCES Person(person_code),
 FOREIGN KEY(personality_ID) REFERENCES Personality(personality_ID)
);



-- Coach Table
-- Stores coaches as a specialization of the Person entity.

--DROP TABLE Coach;

CREATE TABLE Coach (
 coach_code NUMBER(10) NOT NULL,
 PRIMARY KEY(coach_code),
 FOREIGN KEY(coach_code) REFERENCES Person(person_code)
);



-- Technical_Official Table
-- Stores technical officials as a specialization of the Person entity.

--DROP TABLE Technical_Official;

CREATE TABLE Technical_Official (
 tech_code NUMBER(10) NOT NULL,
 organisation VARCHAR2(4),
 PRIMARY KEY(tech_code),
 FOREIGN KEY(tech_code) REFERENCES Person(person_code),
 FOREIGN KEY(organisation) REFERENCES Organization(organisation_code)
);



-- Person_participates Table
-- Relationship table connecting people (athletes, coaches, and technical officials) with the disciplines in which they participate.

--DROP TABLE Person_participates;
CREATE TABLE Person_participates (
   person_code NUMBER(10) NOT NULL,
   discipline  VARCHAR2(255) NOT NULL,
   PRIMARY KEY (person_code, discipline),
   FOREIGN KEY (person_code) REFERENCES Person(person_code),
   FOREIGN KEY (discipline) REFERENCES Discipline(discipline)
);



-- Is_Family_Of Table
-- Stores family relationship information for athletes, including whether the relative is also involved in sports.

--DROP TABLE Is_Family_Of;

CREATE TABLE Is_Family_Of (
 family_code NUMBER(10) NOT NULL,
 family_member CLOB,
 is_sporting_relative VARCHAR2(5) CHECK (is_sporting_relative IN ('True', 'False')),
 PRIMARY KEY(family_code),
 FOREIGN KEY(family_code) REFERENCES Person(person_code)
);



-- Athlete_participates Table
-- Relationship table linking athletes with the events in which they participate.

--DROP TABLE Athlete_participates;

CREATE TABLE Athlete_participates (
 athlete_code NUMBER(10) NOT NULL,
 event_ID NUMBER(10) NOT NULL,
 PRIMARY KEY(athlete_code, event_ID),
 FOREIGN KEY(athlete_code) REFERENCES Athlete(athlete_code),
 FOREIGN KEY(event_ID) REFERENCES Event(event_ID)
);



-- Coach_participates Table
-- Relationship table linking coaches with the events in which they participate.

--DROP TABLE Coach_participates;

CREATE TABLE Coach_participates (
 coach_code NUMBER(10) NOT NULL,
 event_ID   NUMBER(10) NOT NULL,
 PRIMARY KEY (coach_code, event_ID),
 FOREIGN KEY (coach_code) REFERENCES Coach(coach_code),
 FOREIGN KEY (event_ID)   REFERENCES Event(event_ID)
);



-- Members Table
-- Relationship table connecting athletes and coaches through teams.

--DROP TABLE Members;

CREATE TABLE Members (
   athlete_code NUMBER(10) NOT NULL,
   coach_code NUMBER(10) NOT NULL,
   team_code VARCHAR2(25),
   num_athletes NUMBER(10),
   num_coaches NUMBER(10),
   PRIMARY KEY(athlete_code, coach_code),
   FOREIGN KEY(athlete_code) REFERENCES Athlete(athlete_code),
   FOREIGN KEY(coach_code) REFERENCES Coach(coach_code),
   FOREIGN KEY(team_code) REFERENCES Team(team_code)
);



-- Competes Table
-- Relationship table linking teams with the disciplines in which they compete.

--DROP TABLE Competes;

CREATE TABLE Competes (
 team_code  VARCHAR2(25)  NOT NULL,
 discipline VARCHAR2(255) NOT NULL,
 PRIMARY KEY (team_code, discipline),
 FOREIGN KEY (team_code)  REFERENCES Team(team_code),
 FOREIGN KEY (discipline) REFERENCES Discipline(discipline)
);



-- Athlete_wins Table
-- Relationship table linking athletes with the medals they have won.

--DROP TABLE Athlete_wins;
 
CREATE TABLE Athlete_wins (
    medal_ID     NUMBER(10) NOT NULL,
    athlete_code NUMBER(10) NOT NULL,
    is_medallist VARCHAR2(5) CHECK (is_medallist IN ('True', 'False')),
    PRIMARY KEY (medal_ID, athlete_code),
    FOREIGN KEY (medal_ID) REFERENCES Medal(medal_ID),
    FOREIGN KEY (athlete_code) REFERENCES Athlete(athlete_code)
);
 


-- Team_wins Table
-- Relationship table linking teams with the medals they have won.

--DROP TABLE Team_wins;
 
CREATE TABLE Team_wins (
    medal_ID NUMBER(10) NOT NULL,
    team_code VARCHAR2(25) NOT NULL,
    is_medallist VARCHAR2(5) CHECK (is_medallist IN ('True', 'False')),
    PRIMARY KEY(medal_ID, team_code),
    FOREIGN KEY(medal_ID) REFERENCES Medal(medal_ID),
    FOREIGN KEY(team_code) REFERENCES Team(team_code)
);
 


-- Practices Table
-- Relationship table linking athletes with the sports they practice.

--DROP TABLE Practies;

CREATE TABLE Practices (
 athlete_code NUMBER(10) NOT NULL,
 sport_code VARCHAR2(3) NOT NULL,
 other_sports CLOB,
 PRIMARY KEY(athlete_code, sport_code),
 FOREIGN KEY(athlete_code) REFERENCES Athlete(athlete_code),
 FOREIGN KEY(sport_code) REFERENCES Sport(sport_code)
);



-- Works Table
-- Relationship table linking athletes with their occupations.

--DROP TABLE Works;

CREATE TABLE Works (
   athlete_code  NUMBER(10) NOT NULL,
   occupation_ID NUMBER(10) NOT NULL,
   PRIMARY KEY (athlete_code, occupation_ID),
   FOREIGN KEY (athlete_code)  REFERENCES Athlete(athlete_code),
   FOREIGN KEY (occupation_ID) REFERENCES Occupation(occupation_ID)
);



-- Enjoys Table
-- Relationship table linking athletes with their hobbies.

--DROP TABLE Enjoys;

CREATE TABLE Enjoys (
   athlete_code NUMBER(10) NOT NULL,
   hobby_ID NUMBER(10) NOT NULL,
   PRIMARY KEY(athlete_code, hobby_ID),
   FOREIGN KEY(athlete_code) REFERENCES Athlete(athlete_code),
   FOREIGN KEY(hobby_ID) REFERENCES Hobby(hobby_ID)
);



-- Attended Table
-- Relationship table linking athletes with their educational background.

--DROP TABLE Attended;

CREATE TABLE Attended (
   athlete_code NUMBER(10) NOT NULL,
   education_ID NUMBER(10) NOT NULL,
   PRIMARY KEY(athlete_code, education_ID),
   FOREIGN KEY(athlete_code) REFERENCES Athlete(athlete_code),
   FOREIGN KEY(education_ID) REFERENCES Education(education_ID)
);



-- Lives Table
-- Relationship table linking athletes with their residences.

--DROP TABLE Lives;

CREATE TABLE Lives (
 athlete_code NUMBER(10) NOT NULL,
 residence_ID NUMBER(10) NOT NULL,
 PRIMARY KEY (athlete_code, residence_ID),
 FOREIGN KEY (athlete_code) REFERENCES Athlete(athlete_code),
 FOREIGN KEY (residence_ID) REFERENCES Residence(residence_ID)
);



-- Speaks Table
-- Relationship table linking athletes with the languages they speak.

--DROP TABLE Speaks;

CREATE TABLE Speaks (
   athlete_code NUMBER(10) NOT NULL,
   language_ID  NUMBER(10) NOT NULL,
   PRIMARY KEY (athlete_code, language_ID),
   FOREIGN KEY (athlete_code) REFERENCES Athlete(athlete_code),
   FOREIGN KEY (language_ID)  REFERENCES Language(language_ID)
);



-- Citizen Table
-- Relationship table linking athletes with their nationalities.

--DROP TABLE Citizen;

CREATE TABLE Citizen (
 athlete_code NUMBER(10) NOT NULL,
 nationality_code VARCHAR2(3) NOT NULL,
 PRIMARY KEY(athlete_code, nationality_code),
 FOREIGN KEY(athlete_code) REFERENCES Athlete(athlete_code),
 FOREIGN KEY(nationality_code) REFERENCES Nationality(nationality_code)
);



-- Trains Table
-- Relationship table linking athletes with their training sessions.

--DROP TABLE Trains;

CREATE TABLE Trains (
 athlete_code NUMBER(10) NOT NULL,
 training_ID NUMBER(10) NOT NULL,
 PRIMARY KEY(athlete_code, training_ID),
 FOREIGN KEY(athlete_code) REFERENCES Athlete(athlete_code),
 FOREIGN KEY(training_ID) REFERENCES Training(training_ID)
);



-- Supervises Table
-- Relationship table linking coaches with the training sessions they supervise.

--DROP TABLE Supervises;

CREATE TABLE Supervises (
 training_ID NUMBER(10) NOT NULL,
 coach_code NUMBER(10) NOT NULL,
 PRIMARY KEY(training_ID, coach_code),
 FOREIGN KEY(training_ID) REFERENCES Training(training_ID),
 FOREIGN KEY(coach_code) REFERENCES Coach(coach_code)
);
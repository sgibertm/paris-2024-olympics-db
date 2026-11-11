-- G7 CSV Inserts Script
-- Code by Alex Vilamitjana, Oriol Pros and Sara Gibert



-- Country Table
-- Stores the countries and National Olympic Committee (NOC) codes used throughout the database.

INSERT INTO Country (noc_code, country, country_long, tag, note)
SELECT code, country, country_long, tag, note
FROM NOCS;

-- Validation

SELECT COUNT(DISTINCT code)
FROM NOCS;

SELECT COUNT(DISTINCT country)
FROM Country;



-- Sport Table
-- Stores all sports represented in the Olympic dataset.

INSERT INTO Sport (sport_code, sport, tag, sport_url)
SELECT DISTINCT sport_code, sport, tag, sport_url
FROM EVENTS;

-- Validation

SELECT COUNT(DISTINCT sport)
FROM EVENTS;


SELECT COUNT(DISTINCT sport_code)
FROM Sport;



-- Discipline Table
-- Stores the disciplines associated with Olympic events and schedules.

INSERT INTO Discipline (discipline, discipline_code)
SELECT DISTINCT discipline, discipline_code
FROM SCHEDULES;

-- Validation

SELECT COUNT(DISTINCT discipline)
FROM SCHEDULES;

SELECT COUNT(DISTINCT discipline)
FROM Discipline;



-- Venue Table
-- Stores all venues where Olympic events and schedules take place.

INSERT INTO Venue (venue_code, venue_name, tag, url)
SELECT DISTINCT s.venue_code, s.venue, v.tag, v.url
FROM SCHEDULES s
LEFT JOIN VENUES v ON v.venue = s.venue
WHERE s.venue_code IS NOT NULL;

-- Validation

SELECT COUNT(DISTINCT venue_code) FROM SCHEDULES WHERE venue_code IS NOT NULL;

SELECT COUNT(DISTINCT venue_code) FROM Venue;



-- Location Table
-- Stores location codes and descriptions extracted from the schedules dataset.

INSERT INTO Location (location_code, location_description)
SELECT DISTINCT location_code, location_description
FROM SCHEDULES
WHERE location_code IS NOT NULL;

-- Validation

SELECT COUNT(DISTINCT location_code)
FROM SCHEDULES;

SELECT COUNT(DISTINCT location_code)
FROM Location;



-- Organization Table
-- Stores organizations associated with technical officials.

INSERT INTO Organization (organisation_code, organisation, organisation_long)
SELECT DISTINCT organisation_code, organisation, organisation_long
FROM TECHNICAL_OFFICIALS
WHERE organisation_code IS NOT NULL;

-- Validation

SELECT COUNT(DISTINCT organisation_code)
FROM TECHNICAL_OFFICIALS;

SELECT COUNT(DISTINCT organisation_code)
FROM Organization;



-- Personality Table
-- Stores personality-related information about athletes, including inspirations, heroes, rituals, philosophies, and motivations.

INSERT INTO Personality (personality_ID, reason, hero, influence, ritual, philosophy)
SELECT DISTINCT ROWNUM, reason, hero, influence, ritual, philosophy
FROM ATHLETES;

-- Validation

SELECT COUNT(DISTINCT personality_ID)
FROM PERSONALITY;

SELECT COUNT(DISTINCT code)
FROM ATHLETES;



-- Training Table
-- Stores training session information, including date, duration, and intensity level.

INSERT INTO Training (training_ID, training_date, duration, intensity_level)
SELECT DISTINCT training_id, training_date, duration_min, intensity_level
FROM TRAINING_SESSIONS;

-- Validation

SELECT COUNT(*)
FROM Training;



-- Occupation Table
-- Stores occupations associated with athletes.

INSERT INTO Occupation
SELECT ROWNUM, TRIM(REGEXP_SUBSTR(occupation, '[^,]+', 1, 1))
FROM ATHLETES
WHERE REGEXP_SUBSTR(occupation, '[^,]+', 1, 1) IS NOT NULL;

INSERT INTO Occupation
SELECT ROWNUM + 10000, TRIM(REGEXP_SUBSTR(occupation, '[^,]+', 1, 2))
FROM ATHLETES
WHERE REGEXP_SUBSTR(occupation, '[^,]+', 1, 2) IS NOT NULL;

INSERT INTO Occupation
SELECT ROWNUM + 20000, TRIM(REGEXP_SUBSTR(occupation, '[^,]+', 1, 3))
FROM ATHLETES
WHERE REGEXP_SUBSTR(occupation, '[^,]+', 1, 3) IS NOT NULL;

INSERT INTO Occupation
SELECT ROWNUM + 30000, TRIM(REGEXP_SUBSTR(occupation, '[^,]+', 1, 4))
FROM ATHLETES
WHERE REGEXP_SUBSTR(occupation, '[^,]+', 1, 4) IS NOT NULL;

DELETE FROM Occupation o1
WHERE occupation_ID > (
 SELECT MIN(o2.occupation_ID)
 FROM Occupation o2
 WHERE o1.occupation = o2.occupation
);

-- Validation

SELECT COUNT(*)
FROM Occupation;



-- Hobby Table
-- Stores hobbies associated with athletes.

INSERT INTO Hobby (hobby_ID, hobby)
SELECT ROWNUM, hobbies
FROM ATHLETES
WHERE hobbies IS NOT NULL;

-- Validation

SELECT COUNT(DISTINCT hobbies)
FROM ATHLETES
WHERE hobbies IS NOT NULL;

SELECT COUNT(DISTINCT hobby_id)
FROM Hobby;



-- Education Table
-- Stores educational background information for athletes.

INSERT INTO Education (education_ID, education)
SELECT ROWNUM, education
FROM ATHLETES
WHERE education IS NOT NULL;

-- Validation

SELECT COUNT(DISTINCT education)
FROM ATHLETES
WHERE education IS NOT NULL;

SELECT COUNT(DISTINCT education_id)
FROM Education;



-- Residence Table
-- Stores athlete residence information, including residence place and country.

INSERT INTO Residence (residence_ID, residence_place, residence_country)
SELECT DISTINCT ROW_NUMBER() OVER (ORDER BY residence_place, residence_country), residence_place, residence_country
FROM ATHLETES
WHERE residence_place IS NOT NULL;

-- Validation

SELECT COUNT(DISTINCT residence_place || '|' || residence_country) FROM ATHLETES WHERE residence_place IS NOT NULL;

SELECT COUNT(DISTINCT residence_ID) FROM Residence;



-- Language Table
-- Stores languages spoken by athletes.

INSERT INTO Language
SELECT ROWNUM, TRIM(REGEXP_SUBSTR(lang, '[^,]+', 1, 1))
FROM ATHLETES
WHERE REGEXP_SUBSTR(lang, '[^,]+', 1, 1) IS NOT NULL;

INSERT INTO Language
SELECT ROWNUM + 11000, TRIM(REGEXP_SUBSTR(lang, '[^,]+', 1, 2))
FROM ATHLETES
WHERE REGEXP_SUBSTR(lang, '[^,]+', 1, 2) IS NOT NULL;

INSERT INTO Language
SELECT ROWNUM + 20000, TRIM(REGEXP_SUBSTR(lang, '[^,]+', 1, 3))
FROM ATHLETES
WHERE REGEXP_SUBSTR(lang, '[^,]+', 1, 3) IS NOT NULL;

INSERT INTO Language
SELECT ROWNUM + 30000, TRIM(REGEXP_SUBSTR(lang, '[^,]+', 1, 4))
FROM ATHLETES
WHERE REGEXP_SUBSTR(lang, '[^,]+', 1, 4) IS NOT NULL;

INSERT INTO Language
SELECT ROWNUM + 40000, TRIM(REGEXP_SUBSTR(lang, '[^,]+', 1, 5))
FROM ATHLETES
WHERE REGEXP_SUBSTR(lang, '[^,]+', 1, 5) IS NOT NULL;

DELETE FROM Language l1
WHERE language_ID > (
 SELECT MIN(l2.language_ID)
 FROM Language l2
 WHERE l2.language = l1.language
);

-- Validation

SELECT COUNT(*)
FROM Language;



-- Nationality Table
-- Stores nationality information for athletes.

INSERT INTO Nationality (nationality_code, nationality, nationality_long)
SELECT DISTINCT nationality_code, nationality, nationality_long
FROM ATHLETES
WHERE nationality_code IS NOT NULL;

-- Validation

SELECT COUNT(DISTINCT nationality_code) FROM ATHLETES WHERE nationality_code IS NOT NULL;

SELECT COUNT(DISTINCT nationality_code) FROM Nationality;



-- Event Table
-- Stores Olympic events together with their gender category, type, URL, and phase.

INSERT INTO Event (event_ID, event_name, event_gender, event_type, event_url, phase)
SELECT ROW_NUMBER() OVER (ORDER BY event, gender, event_type), event, gender, event_type, MAX(url), MAX(phase)
FROM SCHEDULES
WHERE event IS NOT NULL
GROUP BY event, gender, event_type;

-- Validation

SELECT COUNT(DISTINCT event || gender || event_type) FROM SCHEDULES WHERE event IS NOT NULL;

SELECT COUNT(DISTINCT event_ID) FROM Event;



-- Medal Table
-- Stores medals awarded during Olympic events.

INSERT INTO Medal (medal_ID, medal_type, medal_code, medal_date)
SELECT ROW_NUMBER() OVER (ORDER BY event), medal_type, medal_code, medal_date
FROM MEDALS;

-- Validation

SELECT COUNT(*)
FROM MEDALS
WHERE medal_code IS NOT NULL;

SELECT COUNT(DISTINCT medal_ID)
FROM Medal;



-- Team Table
-- Stores Olympic teams together with their gender category and active status.

INSERT INTO Team (team_code, team_name, team_gender, is_current)
SELECT DISTINCT code, team, team_gender, "current"
FROM TEAMS;

-- Validation

SELECT COUNT(DISTINCT code) FROM TEAMS;

SELECT COUNT(DISTINCT team_code) FROM Team;



-- Person Table
-- Central entity storing shared information for athletes, coaches, and technical officials.

-- This is for athletes
INSERT INTO Person(person_code, second_name, first_name, name_short, name_tv, nickname, is_current, gender, function, birth_date, noc_code, birth_place, birth_country)
SELECT a.code, TRIM(REGEXP_SUBSTR(a.name, '^(([A-Z]{2,}|de|del|von) )+')), TRIM(REGEXP_REPLACE(a.name,'^(([A-Z]{2,}|de|del|von) )+','')),
 a.name_short, a.name_tv, a.nickname, a."current", a.gender, a.function, a.birth_date, a.country_code, a.birth_place, c.noc_code
FROM ATHLETES a
LEFT JOIN Country c ON c.country_long = a.birth_country;

-- Validation

SELECT COUNT(DISTINCT code) FROM ATHLETES;

SELECT COUNT(DISTINCT person_code) FROM Person;

-- This is for coaches
INSERT INTO Person (person_code, second_name, first_name, is_current, gender, function, category, birth_date, noc_code)
SELECT code, TRIM(REGEXP_SUBSTR(name, '^(([A-Z]{2,}|de|del|von) )+')), TRIM(REGEXP_REPLACE(name,'^(([A-Z]{2,}|de|del|von) )+','')), "current", gender, function, category, birth_date, country_code
FROM COACHES;

-- Validation

SELECT COUNT(DISTINCT code) FROM COACHES;

SELECT COUNT(DISTINCT person_code) FROM Person;

-- This is for tech officials
INSERT INTO Person (person_code, second_name, first_name, is_current, gender, function, category, birth_date)
SELECT code, TRIM(REGEXP_SUBSTR(name, '^(([A-Z]{2,}|de|del|von) )+')), TRIM(REGEXP_REPLACE(name,'^(([A-Z]{2,}|de|del|von) )+','')),"current", gender, function, category, birth_date
FROM TECHNICAL_OFFICIALS;

-- Validation

SELECT COUNT(DISTINCT code) FROM TECHNICAL_OFFICIALS;

SELECT COUNT(DISTINCT person_code) FROM Person;



-- Schedule Table
-- Stores Olympic schedules associated with events, venues, and locations.

INSERT INTO Schedule (schedule_ID, day, status, schedule_url, location, venue, event_ID, start_date, end_date)
SELECT ROW_NUMBER() OVER (ORDER BY s.start_date, s.event), s.day, s.status, s.url, s.location_code, s.venue_code, e.event_ID, s.start_date, s.end_date
FROM SCHEDULES s
JOIN Event e ON e.event_name = s.event AND e.event_gender = s.gender AND e.event_type = s.event_type;

-- Validation

SELECT COUNT(*) FROM SCHEDULES WHERE event IS NOT NULL;

SELECT COUNT(DISTINCT schedule_ID) FROM Schedule;



-- Team_represents Table
-- Relationship table connecting teams with the countries they represent.

INSERT INTO Team_represents (team_code, noc_code)
SELECT DISTINCT code, country_code
FROM TEAMS;

-- Validation

SELECT COUNT(DISTINCT code || country_code) FROM TEAMS;

SELECT COUNT(*) FROM Team_represents;



-- Team_participates Table
-- Relationship table connecting teams with the events in which they participate.

INSERT INTO Team_participates (team_code, event_ID)
SELECT DISTINCT t.code, e.event_ID
FROM TEAMS t
JOIN Event e ON e.event_name = TRIM(t.events)
WHERE t.events IS NOT NULL;

-- Validation

SELECT COUNT(*) FROM Team_participates;



-- Awards Table
-- Relationship table linking medals to the events where they were awarded.

INSERT INTO Awards (medal_ID, event_ID)
SELECT MIN(m.medal_ID), e.event_ID
FROM MEDALLISTS ml
JOIN Event  e  ON e.event_name = ml.event AND e.event_type = ml.event_type
JOIN MEDALS md ON md.event = ml.event AND md.medal_type = ml.medal_type
JOIN Medal  m  ON m.medal_type = md.medal_type
    AND m.medal_code = md.medal_code
    AND m.medal_date = md.medal_date
WHERE ml.medal_code IS NOT NULL
GROUP BY e.event_ID, ml.medal_type;
 
-- Validation

SELECT COUNT(DISTINCT event || medal_type) FROM MEDALLISTS WHERE medal_code IS NOT NULL;

SELECT COUNT(*) FROM Awards;



-- Covers Table
-- Relationship table linking schedules with the disciplines they cover.

INSERT INTO Covers (schedule_ID, discipline)
SELECT DISTINCT sch.schedule_ID, s.discipline
FROM SCHEDULES s
JOIN Schedule sch ON  sch.schedule_url = s.url AND sch.location = s.location_code AND sch.venue = s.venue_code
WHERE s.discipline IS NOT NULL;

-- Validation

SELECT COUNT(DISTINCT url || location_code || venue_code || discipline)
FROM SCHEDULES WHERE discipline IS NOT NULL;

SELECT COUNT(*) FROM Covers;



-- Hosts Table
-- Relationship table linking venues with the sports hosted at those venues.

INSERT INTO Hosts (venue_code, sport_code)
SELECT DISTINCT v.venue_code, s.sport_code
FROM Venue v
JOIN VENUES tv ON tv.venue = v.venue_name
JOIN Sport s ON INSTR(tv.sports, s.sport) > 0; -- if it has been found inside the longer string

-- Validation

SELECT COUNT(*) FROM Hosts;



-- Showcases Table
-- Relationship table linking events with the sports they showcase.

INSERT INTO Showcases (event_ID, sport_code)
SELECT DISTINCT e.event_ID, te.sport_code
FROM Event e
JOIN EVENTS te ON te.event = e.event_name;

-- Validation

SELECT COUNT(DISTINCT event || sport_code) FROM EVENTS;

SELECT COUNT(*) FROM Showcases;



-- Athlete Table
-- Stores athlete-specific information extending the Person entity.

INSERT INTO Athlete (athlete_code, height, weight, personality_ID)
SELECT a.code, MAX(a.height), MAX(a.weight), MIN(p.personality_ID)
FROM ATHLETES a
LEFT JOIN Personality p ON p.influence = a.influence
GROUP BY a.code;



-- Coach Table
-- Stores coaches as a specialization of the Person entity.

INSERT INTO Coach (coach_code)
SELECT code FROM COACHES;
SELECT COUNT(DISTINCT code) FROM COACHES;
SELECT COUNT(DISTINCT coach_code) FROM Coach;



-- Technical_Official Table
-- Stores technical officials as a specialization of the Person entity.

INSERT INTO Technical_Official (tech_code, organisation)
SELECT code, organisation_code
FROM TECHNICAL_OFFICIALS;
SELECT COUNT(DISTINCT code) FROM TECHNICAL_OFFICIALS;
SELECT COUNT(DISTINCT tech_code) FROM Technical_Official;



-- Person_participates Table
-- Relationship table connecting people (athletes, coaches, and technical officials) with the disciplines in which they participate.

INSERT INTO Person_participates (person_code, discipline)
SELECT DISTINCT a.code, d.discipline
FROM ATHLETES a
JOIN Discipline d ON REGEXP_LIKE(a.disciplines, '''' || d.discipline || '''')
WHERE a.disciplines IS NOT NULL;

INSERT INTO Person_participates (person_code, discipline)
SELECT DISTINCT c.code, d.discipline
FROM COACHES c
JOIN Discipline d ON d.discipline = TRIM(c.disciplines)
WHERE c.disciplines IS NOT NULL;

INSERT INTO Person_participates (person_code, discipline)
SELECT DISTINCT t.code, d.discipline
FROM TECHNICAL_OFFICIALS t
JOIN Discipline d ON REGEXP_LIKE(t.disciplines, '''' || d.discipline || '''')
WHERE t.disciplines IS NOT NULL;

-- Validation

SELECT COUNT(*) FROM Person_participates;



-- Is_Family_Of Table
-- Stores family relationship information for athletes, including whether the relative is also involved in sports.

INSERT INTO Is_Family_Of (family_code, family_member, is_sporting_relative)
SELECT code, family, 'True'
FROM ATHLETES
WHERE family IS NOT NULL
AND sporting_relatives IS NOT NULL;

INSERT INTO Is_Family_Of (family_code, family_member, is_sporting_relative)
SELECT code, family, 'False'
FROM ATHLETES
WHERE family IS NOT NULL
AND sporting_relatives IS NULL;

-- Validation

SELECT COUNT(*) FROM Is_Family_Of;



-- Athlete_participates Table
-- Relationship table linking athletes with the events in which they participate.

INSERT INTO Athlete_participates (athlete_code, event_ID)
SELECT DISTINCT a.code, e.event_ID
FROM ATHLETES a
JOIN Event e ON INSTR(a.events, e.event_name) > 0
WHERE a.events IS NOT NULL;

-- Validation

SELECT COUNT(*) FROM Athlete_participates;



-- Coach_participates Table
-- Relationship table linking coaches with the events in which they participate.

INSERT INTO Coach_participates (coach_code, event_ID)
SELECT DISTINCT c.code, e.event_ID
FROM COACHES c
JOIN Event e
 ON INSTR(c.events, e.event_name) > 0
WHERE c.events IS NOT NULL;

-- Validation

SELECT COUNT(*) FROM Coach_participates;



-- Members Table
-- Relationship table connecting athletes and coaches through teams.

INSERT INTO Members (athlete_code, coach_code, team_code, num_athletes, num_coaches)
SELECT TO_NUMBER(a.code), TO_NUMBER(c.code), MIN(t.code), MAX(TO_NUMBER(t.num_athletes)), MAX(TO_NUMBER(t.num_coaches))
FROM TEAMS t
JOIN ATHLETES a ON INSTR(t.athletes_codes, a.code) > 0
JOIN COACHES  c ON INSTR(t.coaches_codes,  c.code) > 0
WHERE t.coaches_codes IS NOT NULL
GROUP BY a.code, c.code;

-- Validation

SELECT COUNT(*) FROM Members;



-- Competes Table
-- Relationship table linking teams with the disciplines in which they compete.

INSERT INTO Competes (team_code, discipline)
SELECT DISTINCT t.code, d.discipline
FROM TEAMS t
JOIN Discipline d ON d.discipline_code = t.disciplines_code
WHERE t.disciplines_code IS NOT NULL;

-- Validation

SELECT COUNT(*) FROM Competes;



-- Athlete_wins Table
-- Relationship table linking athletes with the medals they have won.

--DROP TABLE Athlete_wins;

INSERT INTO Athlete_wins (medal_ID, athlete_code, is_medallist)
SELECT DISTINCT m.medal_ID, ml.code_athlete, ml.is_medallist
FROM MEDALLISTS ml
JOIN Event  e  ON e.event_name = ml.event AND e.event_type = ml.event_type
JOIN Awards aw ON aw.event_ID  = e.event_ID
JOIN Medal  m  ON m.medal_ID   = aw.medal_ID AND m.medal_type = ml.medal_type
WHERE ml.code_athlete IS NOT NULL;
 
-- Validation
SELECT COUNT(DISTINCT code_athlete) FROM MEDALLISTS WHERE code_athlete IS NOT NULL;

SELECT COUNT(*) FROM Athlete_wins;



-- Team_wins Table
-- Relationship table linking teams with the medals they have won.

INSERT INTO Team_wins (medal_ID, team_code, is_medallist)
SELECT MIN(m.medal_ID), ml.code_team, MAX(ml.is_medallist)
FROM MEDALLISTS ml
JOIN Event  e  ON e.event_name = ml.event AND e.event_type = ml.event_type
JOIN Awards aw ON aw.event_ID  = e.event_ID
JOIN Medal  m  ON m.medal_ID   = aw.medal_ID AND m.medal_type = ml.medal_type
WHERE ml.code_team IS NOT NULL
GROUP BY ml.code_team, ml.url_event;
 
-- Validation

SELECT COUNT(*) FROM Team_wins;



-- Practices Table
-- Relationship table linking athletes with the sports they practice.

INSERT INTO Practices (athlete_code, sport_code, other_sports)
SELECT DISTINCT a.code, s.sport_code, a.other_sports
FROM ATHLETES a
JOIN Sport s ON INSTR(a.disciplines, s.sport) > 0
WHERE a.disciplines IS NOT NULL;

-- Validation

SELECT COUNT(*) FROM Practices;



-- Works Table
-- Relationship table linking athletes with their occupations.

INSERT INTO Works (athlete_code, occupation_ID)
SELECT DISTINCT
   a.code,
   o.occupation_ID
FROM ATHLETES a
JOIN Occupation o
   ON INSTR(',' || LOWER(a.occupation) || ',', ',' || LOWER(o.occupation) || ',') > 0
WHERE a.occupation IS NOT NULL;

-- Validation

SELECT COUNT(*) FROM Works;



-- Enjoys Table
-- Relationship table linking athletes with their hobbies.

INSERT INTO Enjoys (athlete_code, hobby_ID)
SELECT DISTINCT a.code, h.hobby_ID
FROM ATHLETES a
JOIN Hobby h ON TO_CHAR(h.hobby) = a.hobbies
WHERE a.hobbies IS NOT NULL;

-- Validation

SELECT COUNT(*) FROM Enjoys;



-- Attended Table
-- Relationship table linking athletes with their educational background.

INSERT INTO Attended (athlete_code, education_ID)
SELECT DISTINCT a.code, ed.education_ID
FROM ATHLETES a
JOIN Education ed ON TO_CHAR(ed.education) = a.education
WHERE a.education IS NOT NULL;

-- Validation

SELECT COUNT(*) FROM Attended;



-- Lives Table
-- Relationship table linking athletes with their residences.

INSERT INTO Lives (athlete_code, residence_ID)
SELECT DISTINCT a.code, r.residence_ID
FROM ATHLETES a
JOIN Residence r
 ON  r.residence_place   = a.residence_place
 AND r.residence_country = a.residence_country
WHERE a.residence_place IS NOT NULL;

-- Validation

SELECT COUNT(*) FROM Lives;



-- Speaks Table
-- Relationship table linking athletes with the languages they speak.

INSERT INTO Speaks (athlete_code, language_ID)
SELECT DISTINCT a.code, l.language_ID
FROM ATHLETES a
JOIN Language l ON REGEXP_LIKE(',' || a.lang || ',', ',' || l.language || ',')
WHERE a.lang IS NOT NULL;

-- Validation

SELECT COUNT(*) FROM Speaks;



-- Citizen Table
-- Relationship table linking athletes with their nationalities.

INSERT INTO Citizen (athlete_code, nationality_code)
SELECT DISTINCT code, nationality_code
FROM ATHLETES
WHERE nationality_code IS NOT NULL;

-- Validation

SELECT COUNT(DISTINCT code || nationality_code) FROM ATHLETES WHERE nationality_code IS NOT NULL;

SELECT COUNT(*) FROM Citizen;



-- Trains Table
-- Relationship table linking athletes with their training sessions.

INSERT INTO Trains (athlete_code, training_ID)
SELECT DISTINCT athlete_code, training_ID
FROM TRAINING_SESSIONS;

-- Validation

SELECT COUNT(*) FROM Trains;



-- Supervises Table
-- Relationship table linking coaches with the training sessions they supervise.

INSERT INTO Supervises (training_ID, coach_code)
SELECT DISTINCT training_ID, coach_code
FROM TRAINING_SESSIONS;

-- Validation

SELECT COUNT(*) FROM Supervises;
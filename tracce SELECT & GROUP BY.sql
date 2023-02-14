-- ---------------------------------------  QUERY CON SELECT

-- 1. Selezionare tutti gli studenti nati nel 1990 (160)
SELECT `name`, `surname`, `date_of_birth` 
FROM `students`
WHERE YEAR(date_of_birth) = 1990;

-- 2. Selezionare tutti i corsi che valgono più di 10 crediti (479)
SELECT `name`, `cfu` 
FROM `courses`
where `cfu` > 10;

-- 3. Selezionare tutti gli studenti che hanno più di 30 anni
SELECT `name`, `surname`, YEAR(date_of_birth) AS 'Anno di nascita'
FROM `students`
WHERE (YEAR(date_of_birth) + 30) < YEAR(CURDATE());

-- 4. Selezionare tutti i corsi del primo semestre del primo anno di un qualsiasi corso di laurea (286)
SELECT `name`, `year`, `period` 
FROM `courses`
WHERE `year` = 1
AND `period` = 'I semestre';

-- 5. Selezionare tutti gli appelli d'esame che avvengono nel pomeriggio (dopo le 14) del 20/06/2020 (21)
SELECT * 
FROM `exams`
WHERE `date` = '2020-06-20'
AND `hour` > '14:00:00';

-- 6. Selezionare tutti i corsi di laurea magistrale (38)
SELECT `name` 
FROM `degrees`
WHERE `name` LIKE '%magistrale%';

-- 7. Da quanti dipartimenti è composta l'università? (12)
SELECT COUNT(*) AS 'Totale dipartimenti'
FROM `departments`;

-- 8. Quanti sono gli insegnanti che non hanno un numero di telefono? (50)
SELECT COUNT(*) AS 'Insegnanti senza contatto telefonico' 
FROM `teachers`
WHERE `phone` IS NULL;


-- ------------------------------------------ QUERY CON GROUP BY


-- 1. Contare quanti iscritti ci sono stati ogni anno
SELECT  YEAR(enrolment_date) AS "Anno d'iscrizione", COUNT(*) AS 'Numero iscritti'
FROM `students`
GROUP BY YEAR(enrolment_date);

-- 2. Contare gli insegnanti che hanno l'ufficio nello stesso edificio
SELECT `office_address`, COUNT(*) AS 'Numero insegnanti'
FROM `teachers`
GROUP BY `office_address`;

-- 3. Calcolare la media dei voti di ogni appello d'esame
SELECT `exam_id`, ROUND(AVG(`vote`)) AS 'media voti per ogni appello' 
FROM `exam_student`
WHERE `vote` >= 18
GROUP BY `exam_id`;

-- 4. Contare quanti corsi di laurea ci sono per ogni dipartimento
SELECT `department_id` AS 'Dipartimento n°:', COUNT(*) AS 'Numero di corsi' 
FROM `degrees`
GROUP BY `department_id`;
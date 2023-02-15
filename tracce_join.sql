-- 1. Selezionare tutti gli studenti iscritti al Corso di Laurea in Economia
SELECT `students`.`name`, `students`.`surname`, `degrees`.`name` AS `corso`
FROM `students`
JOIN `degrees`
ON `degrees`.`id` = `students`.`degree_id`
WHERE `degrees`.`name` = 'Corso di Laurea in Economia';

-- 2. Selezionare tutti i Corsi di Laurea del Dipartimento di Neuroscienze  
SELECT `degrees`.`name`, `departments`.`name` AS `department`
FROM `degrees`
JOIN `departments`
ON `departments`.`id` = `degrees`.`department_id`
WHERE `departments`.`name` = 'Dipartimento di Neuroscienze';

-- 3. Selezionare tutti i corsi in cui insegna Fulvio Amato (id=44)
SELECT DISTINCT `degrees`.`name`, `teachers`.`name`, `teachers`.`surname`
FROM `teachers`
JOIN `course_teacher`
on `teachers`.`id` = `course_teacher`.`teacher_id`
JOIN `courses`
ON `courses`.`id` = `course_teacher`.`course_id`
JOIN `degrees`
ON `degrees`.`id` = `courses`.`degree_id`
WHERE `teachers`.`id` = 44;

-- 4. Selezionare tutti gli studenti con i dati relativi al corso di laurea a cui sono iscritti e il relativo dipartimento, in ordine alfabetico per cognome e nome
SELECT `students`.`surname`, `students`.`name`, `departments`.`name` AS `department`, `degrees`.`name` AS `Course-name`, `degrees`.`level`, `degrees`.`email`, `degrees`.`website`
FROM `students`
JOIN `degrees`
ON `degrees`.`id` = `students`.`degree_id`
JOIN `departments`
ON `departments`.`id` = `degrees`.`department_id`
ORDER BY `students`.`surname`;

-- 5. Selezionare tutti i corsi di laurea con i relativi corsi e insegnanti
SELECT `degrees`.`name`, `courses`.`name` AS `course-name`, `teachers`.`name` AS `teacher-name`, `teachers`.`surname`
FROM `degrees`
JOIN `courses`
ON `degrees`.`id` = `courses`.`degree_id`
JOIN `course_teacher`
ON `courses`.`id` = `course_teacher`.`course_id`
JOIN `teachers`
ON `teachers`.`id` = `course_teacher`.`teacher_id`;

-- 6. Selezionare tutti i docenti che insegnano nel Dipartimento di Matematica (54)
SELECT DISTINCT `teachers`.`surname`, `teachers`.`name`, `departments`.`name` AS `department` 
FROM `departments`
JOIN `degrees`
ON `departments`.`id` = `degrees`.`department_id`
JOIN `courses`
ON `degrees`.`id` = `courses`.`degree_id`
JOIN `course_teacher`
ON `courses`.`id` = `course_teacher`.`course_id`
JOIN `teachers`
ON `teachers`.`id` = `course_teacher`.`teacher_id`
WHERE `departments`.`name` = 'Dipartimento di Matematica';

-- 7. BONUS: Selezionare per ogni studente quanti tentativi d’esame ha sostenuto per superare ciascuno dei suoi esami

-- SELECT `students`.`surname`, `students`.`name`, `courses`.`name` AS 'course-name', IF(MAX(`exam_student`.`vote`) < 18, 'non superato', COUNT(*)) AS 'numero appelli', MIN(`exam_student`.`vote`) AS 'voto più basso', MAX(`exam_student`.`vote`) AS 'voto più alto'
-- FROM `exam_student`
-- JOIN `students`
-- ON `students`.`id` = `exam_student`.`student_id` 
-- JOIN `exams`
-- ON `exams`.`id` = `exam_student`.`exam_id`
-- JOIN `courses`
-- ON `courses`.`id` = `exams`.`course_id`
-- GROUP BY `exam_student`.`student_id`, `courses`.`name`;

SELECT `students`.`surname`, `students`.`name`, `courses`.`name` AS 'course-name', COUNT(*) AS 'numero appelli', MIN(`exam_student`.`vote`) AS 'voto più basso', MAX(`exam_student`.`vote`) AS 'voto più alto'
FROM `exam_student`
JOIN `students`
ON `students`.`id` = `exam_student`.`student_id` 
JOIN `exams`
ON `exams`.`id` = `exam_student`.`exam_id`
JOIN `courses`
ON `courses`.`id` = `exams`.`course_id`
GROUP BY `exam_student`.`student_id`, `courses`.`name`
HAVING MAX(`exam_student`.`vote`) >= 18;
-- Does going to university in a different country affect your mental health? A Japanese international university surveyed its students in 2018 and published a study the following year that was approved by several ethical and regulatory boards. The study found that international students have a higher risk of mental health difficulties than the general population, and that social connectedness (belonging to a social group) and acculturative stress (stress associated with joining a new culture) are predictive of depression.


SELECT stay, count(*) as count_int,round(avg(todep),2) as average_phq, round(avg(tosc),2) as average_scs, round(avg(toas),2) as average_as
FROM public.students
WHERE stay IS NOT NULL AND inter_dom = 'Inter'
GROUP BY stay
ORDER BY stay desc;

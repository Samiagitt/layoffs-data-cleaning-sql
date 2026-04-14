## Remove Duplicates
## standardizing data
## handle null values

CREATE TABLE layoffs_staging
LIKE layoffs;

SELECT * 
FROM layoffs_staging;

INSERT layoffs_staging
SELECT* 
FROM layoffs;

## FINDING DUPLICATES and DELETE

SELECT * ,
ROW_NUMBER() OVER(
PARTITION BY company,industry,total_laid_off,percentage_laid_off,`date`,stage,country) AS row_num
FROM layoffs_staging;

WITH duplicates_cte AS
(
SELECT * ,
ROW_NUMBER() OVER(
PARTITION BY company,industry,total_laid_off,percentage_laid_off,`date`,stage,country, funds_raised_millions) AS row_num
FROM layoffs_staging
)
SELECT * 
FROM duplicates_cte
WHERE row_num>1;

WITH duplicates_cte AS
(
SELECT * ,
ROW_NUMBER() OVER(
PARTITION BY company,industry,total_laid_off,percentage_laid_off,`date`,stage,country, funds_raised_millions) AS row_num
FROM layoffs_staging
)
DELETE 
FROM duplicates_cte
WHERE row_num>1;

CREATE TABLE `layoffs_staging2` (
  `company` text,
  `location` text,
  `industry` text,
  `total_laid_off` int DEFAULT NULL,
  `percentage_laid_off` text,
  `date` text,
  `stage` text,
  `country` text,
  `funds_raised_millions` int DEFAULT NULL,
  `row_num` INT
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

SELECT * 
FROM layoffs_staging2;

INSERT INTO layoffs_staging2
SELECT * ,
ROW_NUMBER() OVER(
PARTITION BY company,industry,total_laid_off,percentage_laid_off,`date`,stage,country, funds_raised_millions) AS row_num
FROM layoffs_staging;

SELECT * 
FROM layoffs_staging2
WHERE row_num>1;

DELETE
FROM layoffs_staging2
WHERE row_num>1;

SELECT * 
FROM layoffs_staging2
WHERE row_num>1;

##Standardizing data

SELECT company,TRIM(company)
FROM layoffs_staging2;

UPDATE layoffs_staging2
SET company=TRIM(company)

UPDATE layoffs_staging2
SET industry='Crypto'
Where industry LIKE 'Crypto%';

SELECT DISTINCT industry
FROM layoffs_staging2;

SELECT*
FROM layoffs_staging2
WHERE country LIKE 'United States%';

SELECT DISTINCT country, TRIM(TRAILING '.' FROM country)
FROM layoffs_staging2
ORDER BY 1

UPDATE layoffs_staging2
SET country= TRIM(TRAILING '.' FROM country)
WHERE country LIKE 'United States%'

SELECT DISTINCT country
FROM layoffs_staging2
ORDER BY 1;

SELECT `date`,
str_to_date(`date`,'%m/%d/%Y')
FROM layoffs_staging2;

UPDATE layoffs_staging2
SET `date`=str_to_date(`date`,'%m/%d/%Y');

ALTER TABLE layoffs_staging2
MODIFY COLUMN `date` DATE;

SELECT * 
FROM layoffs_staging2;

##Handling null values


SELECT * 
FROM layoffs_staging2
WHERE total_laid_off IS NULL
AND percentage_laid_off IS NULL;

SELECT *
FROM layoffs_staging2
WHERE industry IS NULL 
OR industry='';

SELECT t1.industry, t2.industry
FROM layoffs_staging2 t1
JOIN layoffs_staging2 t2
     ON t1.company=t2.company
WHERE (t1.industry IS NULL OR t1.industry='')
AND t2.industry IS NOT NULL;


UPDATE layoffs_staging2 t1
JOIN layoffs_staging2 t2
   ON t1.company=t2.company
SET t1.industry=t2.industry
WHERE t1.industry IS NULL 
AND t2.industry IS NOT NULL;

SELECT * 
FROM layoffs_staging2 
WHERE total_laid_off IS NULL
AND percentage_laid_off IS NULL;

## deleting columns and rows where its blank

ALTER TABLE layoffs_staging2
DROP COLUMN row_num;

SELECT MAX(total_laid_off), max(percentage_laid_off)
FROM layoffs_staging2

SELECT * 
FROM layoffs_staging2 
WHERE percentage_laid_off=1
ORDER BY total_laid_off DESC;

SELECT industry, SUM(total_laid_off)
FROM layoffs_staging2
GROUP BY industry
ORDER BY 2 DESC;

SELECT YEAR(`date`), SUM(total_laid_off)
FROM layoffs_staging2
GROUP BY YEAR(`date`)
ORDER BY 2 DESC;

SELECT SUBSTRING(`DATE`,1,7) AS `MONTH`, SUM(total_laid_off)
FROM layoffs_staging2
group by `MONTH`
order by 1 asc;

SELECT company,year(`date`), SUM(total_laid_off)
FROM layoffs_staging2
GROUP BY company, YEAR(`date`)
ORDER BY 3 DESC;

WITH company_year(company,years,total_laid_off) AS
(
SELECT company,year(`date`), SUM(total_laid_off)
FROM layoffs_staging2
GROUP BY company, YEAR(`date`)
), COMPANY_YEAR_RANK AS
(SELECT *,DENSE_RANK() OVER (PARTITION BY years ORDER BY total_laid_off DESC) as ranking
FROM company_year
where years IS NOT NULL
)
SELECT * 
FROM COMPANY_YEAR_RANK
WHERE ranking<=5;




SELECT * FROM layoffs_raw;

-- create a copy of actual data
CREATE TABLE layoffs_raw
LIKE layoffs;

-- inserting data into it
INSERT INTO layoffs_raw
SELECT * FROM layoffs;

-- Actual Data Cleaning activity starts here.
/*
Probable issues: 
1. incorrect dtype
2. duplicates
3. NULL & blank values
4. inconsistencies
*/
-- ###### 1. incorrect dtype
DESCRIBE layoffs;
SELECT percentage_laid_off, `date` FROM layoffs;
-- 1. percentage_laid_off: text -> float 
ALTER TABLE layoffs
MODIFY percentage_laid_off FLOAT;

-- 2. date: text -> date
UPDATE layoffs
SET `date` = STR_TO_DATE(`date`, '%m/%d/%Y'); -- '%m/%d/%Y' represents the text format in my data

ALTER TABLE layoffs
MODIFY COLUMN `date` DATE;

-- ###### 2. duplicates
CREATE TABLE back_up AS
SELECT DISTINCT * FROM layoffs; -- as all the rows combined create duplicated record

TRUNCATE TABLE layoffs;

INSERT INTO layoffs
SELECT * FROM back_up;

DROP TABLE back_up;


-- ###### 3. NULL & blank values
/* Checking before deleting
SELECT * FROM layoffs
WHERE total_laid_off IS NULL AND percentage_laid_off IS NULL AND funds_raised_millions IS NULL;
*/
DELETE FROM layoffs
WHERE total_laid_off IS NULL AND percentage_laid_off IS NULL AND funds_raised_millions IS NULL;

/* Checking for NULL values in 'industry' column
SELECT * FROM layoffs
WHERE industry IS NULL OR industry = '';
 
SELECT t1.company, t1.total_laid_off, t1.industry, t2.industry FROM layoffs t1
JOIN layoffs t2 
ON t1.company = t2.company
WHERE (t1.industry IS NULL OR t1.industry = '')
AND t2.industry IS NOT NULL;
*/
-- we need to replace blanks with null values to replace them with value from other table.
UPDATE layoffs
SET industry = NULL
WHERE industry = '';

UPDATE layoffs t1
JOIN layoffs t2 ON t1.company = t2.company
SET t1.industry = t2.industry
WHERE (t1.industry IS NULL OR t1.industry = '')
AND t2.industry IS NOT NULL;

-- ###### 4. inconsistencies & other issues
SELECT company, TRIM(company)
FROM layoffs;

UPDATE layoffs
SET company = TRIM(company);

/* 
this removes any other character except letters(ucase/lcase), numbers or white space
===> SELECT company, REGEXP_REPLACE(company, '[^a-zA-Z0-9 ]', '') AS cleaned_com FROM layoffs;
*/
UPDATE layoffs
SET company = REGEXP_REPLACE(company, '[^a-zA-Z0-9 ]', '');

-- below codes are for checking purpose['industry' column]
/*
SELECT DISTINCT industry FROM layoffs ORDER BY 1;

SELECT * FROM layoffs
WHERE industry LIKE '%crypto%';
*/
UPDATE layoffs
SET industry = 'Crypto'
WHERE industry LIKE '%crypto%';

-- below codes are for checking purpose['country' column]
/*
SELECT DISTINCT country FROM layoffs ORDER BY 1;

SELECT * FROM layoffs
WHERE country LIKE '%states%';
*/
UPDATE layoffs
SET country = 'United States'
WHERE country LIKE '%states%';
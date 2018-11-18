-- Create a table to store decimal values as follows:
CREATE TABLE expdata (
id INT UNSIGNED NOT NULL AUTO_INCREMENT PRIMARY KEY,
value FLOAT,
INDEX (value)
);

-- 2. Insert some data:
INSERT INTO expdata (value) VALUES (.01) ,(.1) ,(1) ,(10) ,(100);

-- Add a new column (named log10_value) for the transformed values.
alter table expdata add log10_value float;

-- Add an index on these new column (named log10 value)
ALTER TABLE expdata ADD INDEX transformedValues (log10_value);

-- 5. Update the table with the transformed values
UPDATE expdata SET log10_value = LOG10 (value);

-- Create an INSERT trigger to initialize the log10 value value from value for new rows, and an UPDATE
-- trigger to keep log10 value up to date when value changes
DELIMITER //
CREATE TRIGGER exp_insert
BEFORE
INSERT ON expdata
FOR EACH ROW
BEGIN
  SET new.log10_value = LOG10(new.value);
END//
DELIMITER ;

DELIMITER //
CREATE TRIGGER expdata_update
BEFORE
UPDATE ON expdata
FOR EACH ROW
BEGIN
  SET new.log10_value = LOG10(new.value);
END//
DELIMITER ;

-- To test the implementation, insert and modify some data and check the result of each operation
INSERT INTO expdata(value) values(1000),(10000);

UPDATE expdata SET
  value = 100
  WHERE id = 1
;

--------------------------------------------------------------------------------
-- PART 2
--------------------------------------------------------------------------------

-- Create a table as follows:
CREATE TABLE contact_info (
id INT NOT NULL AUTO_INCREMENT,
name VARCHAR (30),
email VARCHAR (50),
url VARCHAR (255),
PRIMARY KEY (id)
);

-- For entry of new rows, you want to enforce constraints or perform preprocessing as follows:
-- – Email address values must contain an @ character to be valid.
-- – For website URLs, strip any leading ’http://’ to save space

DELIMITER //
CREATE TRIGGER contact_info_insert
BEFORE
INSERT ON contact_info
FOR EACH ROW
BEGIN
  IF new.email NOT LIKE '%@%' THEN
  SIGNAL SQLSTATE '45000'
  SET MESSAGE_TEXT = 'Email must contain an @ symbol';
  END IF;
  SET new.url = TRIM('http://' from new.url);
END//
DELIMITER ;

-- Test the trigger by executing some INSERT statements to verify that it accepts valid values, rejects
-- bad ones, and trims URLs:

INSERT INTO contact_info (name, email, url)
VALUES ('Jen', 'jen@example.com', 'http://www.example.com');

INSERT INTO contact_info (name, email, url)
VALUES ('Jen' ,'jen' , 'http://www.example.com');

SELECT * FROM contact_info;

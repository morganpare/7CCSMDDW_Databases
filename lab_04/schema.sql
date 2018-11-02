CREATE TABLE artist (
  id INT NOT NULL AUTO_INCREMENT,
  name VARCHAR(20) NOT NULL UNIQUE,
  birthPlace VARCHAR (20) NOT NULL,
  age INT NOT NULL,
  style VARCHAR(20) NOT NULL,
  PRIMARY KEY (id)
);

CREATE TABLE artwork (
  id INT NOT NULL AUTO_INCREMENT,
  title VARCHAR(20) NOT NULL UNIQUE,
  artist_id INT NOT NULL,
  year INT NOT NULL,
  price FLOAT NOT NULL,
  type VARCHAR(20) NOT NULL,
  PRIMARY KEY (id),
  FOREIGN KEY (artist_id) REFERENCES artist(id)
);

CREATE TABLE style (
  id INT NOT NULL AUTO_INCREMENT,
  name VARCHAR(20) NOT NULL UNIQUE,
  PRIMARY KEY (id)
);

CREATE TABLE classified (
  artist_id INT NOT NULL,
  style_id INT NOT NULL,
  PRIMARY KEY (artist_id, style_id),
  FOREIGN KEY (artist_id) REFERENCES artist(id),
  FOREIGN KEY (style_id) REFERENCES style(id)
);

ALTER TABLE style RENAME artStyle;

ALTER TABLE artStyle ADD COLUMN description VARCHAR(50);

ALTER TABLE artStyle CHANGE description description VARCHAR(100);

ALTER TABLE artwork CHANGE price price FLOAT NOT NULL DEFAULT 0;

ALTER TABLE artStyle CHANGE description description VARCHAR(100) NOT NULL;

ALTER TABLE artStyle DROP COLUMN description;

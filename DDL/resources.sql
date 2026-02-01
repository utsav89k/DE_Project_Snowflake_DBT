CREATE FILE FORMAT IF NOT EXISTS csv_format
  TYPE = 'CSV' 
  FIELD_DELIMITER = ','
  SKIP_HEADER = 1
  ERROR_ON_COLUMN_COUNT_MISMATCH = FALSE;

SHOW FILE FORMATS;

CREATE OR REPLACE STAGE snowstage
FILE_FORMAT = csv_format
URL='/AWS S3 Container URL/';

SHOW STAGES;

COPY INTO BOOKINGS
FROM @snowstage
FILES=('bookings.csv')
CREDENTIALS=(aws_key_id = '', aws_secret_key = '');

COPY INTO HOSTS
FROM @snowstage
FILES=('hosts.csv')
CREDENTIALS=(aws_key_id = '', aws_secret_key = '');

COPY INTO LISTINGS
FROM @snowstage
FILES=('listings.csv')
CREDENTIALS=(aws_key_id = '', aws_secret_key = '');


select * from listings;
select * from hosts;
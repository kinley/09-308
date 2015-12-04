
##Lection 11

----------

index = BTree

----------

CREATE INDEX idx_name ON lbl_name(col_name)

----------

UNIQUE, PRIMARY KEY создают индексы

----------

- PRIMARY KEY = NOT NULL
- UNIQUE = NULL
- => индексы можно использовать на нулях

----------

CREATE UNIQUE INDEX

----------

- частичные индексы (WHERE <>)
- state: published/unpublished
- WHERE state = "published"

----------

- CREATE INDEX
- WHERE NOT (ip BETWEEN '192.168.0.1' 
- AND '192.168.0.255')
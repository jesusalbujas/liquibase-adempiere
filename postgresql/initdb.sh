#!/bin/bash
createdb -U adempiere seed && \
pg_restore -U adempiere -v -d adempiere < /tmp/seed.backup && \
pg_restore -U adempiere -v -d seed < /tmp/seed.backup

from datetime import datetime


def postgresql_timestamp_to_datetime(timestamp):
    return datetime.fromisoformat(timestamp)

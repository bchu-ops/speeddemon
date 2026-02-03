"""Data extraction placeholders for SpeedDemon.

Functions should be implemented to pull data from Kafka/APIs/DBs.
"""

from typing import Any, Dict


def extract(source: str) -> Dict[str, Any]:
    """Placeholder: extract raw data from `source` and return as dict.

    Args:
        source: connection string or identifier for data source

    Returns:
        A dict representing raw data payload
    """
    # TODO: implement real extraction logic
    return {"source": source, "data": []}


if __name__ == "__main__":
    print(extract("example_source"))

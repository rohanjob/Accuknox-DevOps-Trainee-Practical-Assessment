import requests
import sys

def check_app_status(url):
    try:
        response = requests.get(url, timeout=5)
        if response.status_code == 200:
            print(f"Status: UP (HTTP {response.status_code})")
        else:
            print(f"Status: DOWN (HTTP {response.status_code})")
    except requests.exceptions.RequestException as e:
        print(f"Status: DOWN (Error: {e})")

if __name__ == "__main__":
    if len(sys.argv) < 2:
        print("Usage: python app_health_checker.py <URL>")
        sys.exit(1)
    
    target_url = sys.argv[1]
    check_app_status(target_url)

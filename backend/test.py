from argon2 import PasswordHasher
from argon2.exceptions import VerifyMismatchError

# Create a password hasher object
ph = PasswordHasher()

# Hash a password
hashed_password = ph.hash("welcometovit")
print(hashed_password)

# Verify a password
try:
    ph.verify(hashed_password, "password123")
    print("Password is valid")
except VerifyMismatchError:
    print("Password is invalid")

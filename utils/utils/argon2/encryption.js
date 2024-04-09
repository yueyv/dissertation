import argon2 from 'argon2';

async function hashPassword(password) {
  try {
    const hash = await argon2.hash(password);
    return hash;
  } catch (error) {
    console.error('Error hashing password:', error);
    throw error;
  }
}

// 示例用法
const password = '12345678';
hashPassword(password)
  .then(hash => {
    console.log('Hashed password:', hash);
  })
  .catch(error => {
    console.error('Error:', error);
  });

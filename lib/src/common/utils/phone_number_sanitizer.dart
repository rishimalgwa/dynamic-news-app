sanitizePhoneNumber(String phone) {
  if (phone.length > 10 && phone.startsWith('0')) {
    phone = phone.replaceFirst('0', '');
  }
  if (phone.length > 10 && phone.startsWith('91')) {
    phone = phone.replaceFirst('91', '');
  }
  if (phone.startsWith('+91')) {
    return phone;
  }
  return '+91$phone';
}

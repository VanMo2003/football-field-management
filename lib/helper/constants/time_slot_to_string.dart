String timeSlotToString(int timeSlot) {
  switch (timeSlot) {
    case 1:
      return '10h30-12h00';
    case 2:
      return '12h00-13h30';
    case 3:
      return '13h30-15h00';
    case 4:
      return '15h00-16h30';
    case 5:
      return '16h30-18h00';
    case 6:
      return '18h00-19h30';
    case 7:
      return '19h30-21h00';
    default:
      return '';
  }
}

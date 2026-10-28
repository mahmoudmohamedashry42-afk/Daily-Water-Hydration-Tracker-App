double calculateWaterLitres({
  required int weightKg,
  required double activityHours,
}) {
  final int baseMl = weightKg * 35;
  final double activityMl = activityHours * 250;
  final double totalMl = baseMl + activityMl;
  return totalMl / 1000;
}

String getGuidanceText(double litres) {
  if (litres < 2.0) {
    return 'A relatively low estimate within this educational formula. Consider distributing your water intake evenly throughout the day.\n\nتوزيع شرب الماء على مدار اليوم يمكن أن يساعدك. تقدير منخفض نسبياً ضمن هذه المعادلة التعليمية.';
  } else if (litres <= 3.0) {
    return 'A moderate estimate within this educational formula. Try spacing your intake across intervals during the day.\n\nحاول توزيع الشرب على فترات خلال اليوم. تقدير متوسط ضمن هذه المعادلة التعليمية.';
  } else {
    return 'A relatively high estimate due to weight or activity hours. Actual needs vary from person to person; consult a specialist if needed.\n\nتقدير مرتفع نسبياً بسبب الوزن أو ساعات النشاط. الاحتياج الفعلي يختلف من شخص لآخر، ويمكن استشارة مختص عند الحاجة.';
  }
}

import '../../../core/theme/app_colors.dart';
import '../model/testimonial_model.dart';

class TestimonialsData {
  TestimonialsData._();

  static final List<Testimonial> testimonials = [
    Testimonial(
      id: '1',
      name: 'Ahmed Khan',
      role: 'Product Manager',
      company: 'HealthTech Solutions',
      content:
          "Sana Ullah delivered exceptional work on our medical device integration app. His understanding of complex healthcare requirements and ability to implement secure, reliable serial communication was impressive. The app has been running flawlessly in our facilities.",
      rating: 5.0,
      projectWorkedOn: 'Medical Device App',
      date: DateTime(2024, 12),
      source: TestimonialSource.direct,
      accentColor: AppColors.primary,
    ),
    Testimonial(
      id: '2',
      name: 'Sarah Mitchell',
      role: 'Founder & CEO',
      company: 'AppVenture Studio',
      content:
          "Working with Sana was a pleasure. He built our expense tracking app with clean architecture and attention to detail. The multi-currency feature and biometric authentication were implemented perfectly. Highly recommend for any Flutter project!",
      rating: 5.0,
      projectWorkedOn: 'Expense Tracker',
      date: DateTime(2024, 11),
      source: TestimonialSource.upwork,
      accentColor: AppColors.success,
    ),
    Testimonial(
      id: '3',
      name: 'Muhammad Ali',
      role: 'Restaurant Owner',
      company: 'Izzana Restaurant',
      content:
          "The POS system Sana developed transformed our restaurant operations. The offline-first approach means we never miss an order, even during internet outages. The UI is intuitive and our staff learned it quickly. Outstanding work!",
      rating: 5.0,
      projectWorkedOn: 'Izzana POS',
      date: DateTime(2023, 5),
      source: TestimonialSource.direct,
      accentColor: AppColors.warning,
    ),
    Testimonial(
      id: '4',
      name: 'Jennifer Lee',
      role: 'Technical Director',
      company: 'Mega Minds Studio',
      content:
          "Sana consistently delivered high-quality Flutter applications during his time with us. He published over 10 apps, optimized performance significantly, and mentored junior developers. His work ethic and technical skills are exceptional.",
      rating: 5.0,
      date: DateTime(2024, 6),
      source: TestimonialSource.linkedin,
      accentColor: AppColors.linkedin,
    ),
    Testimonial(
      id: '5',
      name: 'Anonymous',
      role: 'Startup Founder',
      company: 'E-Commerce Startup',
      isAnonymous: true,
      content:
          "Excellent developer! Built our marketplace app from scratch with all the features we needed - vendor management, real-time chat, and secure payments. Communication was great throughout the project. Would definitely work with again.",
      rating: 5.0,
      projectWorkedOn: 'Khareedo Farokht',
      date: DateTime(2023, 2),
      source: TestimonialSource.fiverr,
      accentColor: AppColors.success,
    ),
    Testimonial(
      id: '6',
      name: 'David Chen',
      role: 'CTO',
      company: 'Cross Sonic',
      content:
          "Sana brought valuable expertise to our healthcare projects. His implementation of clean architecture reduced our codebase complexity by 30%. He's also great at mentoring - our junior developers learned a lot from his code reviews.",
      rating: 5.0,
      date: DateTime(2025, 1),
      source: TestimonialSource.direct,
      accentColor: AppColors.accent,
    ),
    Testimonial(
      id: '7',
      name: 'Fatima Zahra',
      role: 'Project Manager',
      company: 'ITZone Technology',
      content:
          "Professional, skilled, and always delivers on time. The restaurant POS system Sana built exceeded our expectations. His attention to UI/UX details resulted in a 4.5+ star rating from users. Great communication throughout!",
      rating: 5.0,
      projectWorkedOn: 'Restaurant POS',
      date: DateTime(2023, 6),
      source: TestimonialSource.direct,
      accentColor: AppColors.error,
    ),
    Testimonial(
      id: '8',
      name: 'Anonymous',
      role: 'Business Owner',
      company: 'Retail Business',
      isAnonymous: true,
      content:
          "Hired Sana for a custom Flutter app and was impressed by the quality. He understood our requirements quickly, suggested improvements, and delivered ahead of schedule. The app performs great and our customers love it.",
      rating: 4.5,
      date: DateTime(2024, 8),
      source: TestimonialSource.upwork,
      accentColor: AppColors.success,
    ),
  ];

  static List<Testimonial> get featured => testimonials.take(6).toList();

  static List<Testimonial> getBySource(TestimonialSource source) {
    return testimonials.where((t) => t.source == source).toList();
  }

  static TestimonialStats get stats {
    final total = testimonials.length;
    final avgRating =
        testimonials.map((t) => t.rating).reduce((a, b) => a + b) / total;
    final fiveStar = testimonials.where((t) => t.rating == 5.0).length;

    return TestimonialStats(
      totalReviews: total,
      averageRating: double.parse(avgRating.toStringAsFixed(1)),
      fiveStarCount: fiveStar,
      satisfactionRate: 100,
    );
  }
}

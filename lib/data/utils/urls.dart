class Urls{
  Urls._();
  static final String baseUrl = "https://task.teamrabbil.com/api/v1";
  static final String registation = "$baseUrl/registration";
  static final String login = "$baseUrl/login";
  static final String createTask = "$baseUrl/createTask";
  static final String taskStatusCount = "$baseUrl/taskStatusCount";
  static final String newTask = "$baseUrl/listTaskByStatus/New";
  static final String inProgressTask = "$baseUrl/listTaskByStatus/Progress";
  static String deleteTask(String id) => "$baseUrl/deleteTask/$id";
  static String updateTask(String id,String status) => "$baseUrl/updateTaskStatus/$id/$status";
  static final String profileUpdate = "$baseUrl/profileUpdate";
  static String sendOtpToEmail(String email) => "$baseUrl/RecoverVerifyEmail/$email";
  static String otpVerify(String email, String otp) => "$baseUrl/RecoverVerifyOTP/$email/$otp";
  static String resetPassword = "$baseUrl/RecoverResetPass";

}
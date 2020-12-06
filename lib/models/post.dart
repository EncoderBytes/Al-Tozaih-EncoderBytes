class Post {
  final String profileImage;
  final String resturentName;
  final double rating;
  final String time;
  final String mealImage;
  final String persons;

  Post(
      {this.profileImage,
      this.resturentName,
      this.rating,
      this.time,
      this.mealImage,
      this.persons});
}

List<Post> posts = [
  new Post(
      resturentName: "Palm Marquee",
      profileImage: 'assets/adelle.jpg',
      mealImage: 'assets/story1.jpg',
      persons: '12',
      rating: 4,
      time: '12:00 PM | 12/1/2021'),
  new Post(
      resturentName: "Sheraz Ronaq",
      profileImage: 'assets/andrew.jpg',
      mealImage: 'assets/story2.jpg',
      persons: '2',
      rating: 1,
      time: '1:00 PM | 1/1/2021'),
  new Post(
      resturentName: "Haleem Ghar",
      profileImage: 'assets/andy.jpg',
      mealImage: 'assets/story3.jpg',
      persons: '12',
      rating: 5,
      time: '5:00 PM | 09/1/2021'),
  new Post(
      resturentName: "Shinwari resturent",
      profileImage: 'assets/marcus.jpg',
      mealImage: 'assets/story4.jpg',
      persons: '2',
      rating: 1,
      time: '5:00 PM | 09/1/2021'),
];

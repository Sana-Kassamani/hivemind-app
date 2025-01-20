enum UserTypes {
  Owner,
  Beekeeper;

  static bool isOwner(String type) => type == "Owner";
  static bool isBeekeeper(String type) => type == "Beekeeper";
}

import 'package:dart_flutter/src/domain/entity/blind_date_team.dart';

class Proposal {
  int proposalId;
  DateTime createdTime;
  BlindDateTeam requestingTeam;
  BlindDateTeam requestedTeam;

  Proposal({
    required this.proposalId,
    required this.createdTime,
    required this.requestingTeam,
    required this.requestedTeam
  });
}

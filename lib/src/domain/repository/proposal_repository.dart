import '../entity/proposal.dart';

abstract interface class ProposalRepository {
  Future<void> requestChat(int myTeamId, int targetTeamId);
  Future<Proposal> acceptChatProposal(int proposalId);
  Future<Proposal> rejectChatProposal(int proposalId);
  Future<List<Proposal>> getMyRequestedProposals();
  Future<List<Proposal>> getMyReceivedProposals();
}
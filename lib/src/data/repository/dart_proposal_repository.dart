import 'package:dart_flutter/src/data/datasource/dart_api_remote_datasource.dart';
import 'package:dart_flutter/src/data/model/proposal_request_dto.dart';
import 'package:dart_flutter/src/domain/entity/proposal.dart';
import 'package:dart_flutter/src/domain/repository/proposal_repository.dart';

class DartProposalRepository implements ProposalRepository {
  static const String PROPOSAL_ACCEPT = "PROPOSAL_SUCCESS";
  static const String PROPOSAL_REJECT = "PROPOSAL_FAILED";

  @override
  Future<void> requestChat(int myTeamId, int targetTeamId) async {
    ProposalRequestDto proposalRequestDto = ProposalRequestDto(
        requestedTeamId: myTeamId,
        requestingTeamId: targetTeamId
    );
    await DartApiRemoteDataSource.postProposal(proposalRequestDto);
  }

  /// 제안 수락이후 채팅방 생성에 대한 책임이 Client에 있으므로 반드시 this.createChatRoom 을 연계할 것
  @override
  Future<Proposal> acceptChatProposal(int proposalId) async {
    return (await DartApiRemoteDataSource.patchProposal(proposalId, PROPOSAL_ACCEPT)).newProposal();
  }

  @override
  Future<Proposal> rejectChatProposal(int proposalId) async {
    return (await DartApiRemoteDataSource.patchProposal(proposalId, PROPOSAL_REJECT)).newProposal();
  }

  @override
  Future<List<Proposal>> getMyReceivedProposals() async {
    var list = await DartApiRemoteDataSource.getProposalList(true);
    return list.map((proposal) => proposal.newProposal()).toList();
  }

  @override
  Future<List<Proposal>> getMyRequestedProposals() async {
    var list = await DartApiRemoteDataSource.getProposalList(false);
    return list.map((proposal) => proposal.newProposal()).toList();
  }
}
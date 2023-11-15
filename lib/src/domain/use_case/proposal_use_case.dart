import 'package:dart_flutter/src/data/datasource/proposal_count_local_datasource.dart';

class ProposalUseCase {
  int getLeftProposal() {
    return ProposalCountLocalDatasource.getLeftProposal();
  }

  DateTime getLastUpdateDate() {
    return ProposalCountLocalDatasource.getLastUpdateDate();
  }

  DateTime getLastAdmobDate() {
    return ProposalCountLocalDatasource.getLastAdmobDate();
  }

  Future<void> setLastAdMobDate(DateTime dateTime) async {
    await ProposalCountLocalDatasource.setLastAdmobDate(dateTime);
  }

  Future<void> setDailyProposal() async {
    await ProposalCountLocalDatasource.setDailyProposal();
  }

  Future<void> subOneProposal() async {
    var newProposal = ProposalCountLocalDatasource.getLeftProposal() - 1;
    await ProposalCountLocalDatasource.setProposal(newProposal);
  }
}

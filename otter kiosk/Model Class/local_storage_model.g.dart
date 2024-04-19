// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'local_storage_model.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class HiveModelAdapter extends TypeAdapter<HiveModel> {
  @override
  final int typeId = 0;

  @override
  HiveModel read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return HiveModel(
      waiverid: fields[0] as String?,
      waivername: fields[28] as String?,
      fname: fields[1] as String?,
      lname: fields[2] as String?,
      gender: fields[3] as String?,
      dob: fields[5] as String?,
      email: fields[4] as String?,
      phone: fields[6] as String?,
      countrycode: fields[7] as String?,
      waivertype: fields[8] as String?,
      localcity: fields[9] as String?,
      localcountry: fields[10] as String?,
      localzipcode: fields[11] as String?,
      localstate: fields[12] as String?,
      localstreet: fields[13] as String?,
      emergencyname: fields[14] as String?,
      emergencyphone: fields[15] as String?,
      emergencycode: fields[16] as String?,
      city: fields[17] as String?,
      country: fields[18] as String?,
      zipcode: fields[19] as String?,
      state: fields[20] as String?,
      street: fields[21] as String?,
      identificationType: fields[22] as String?,
      identificationcountry: fields[23] as String?,
      identificationstate: fields[24] as String?,
      identificationid: fields[25] as String?,
      hearaboutus: (fields[26] as List?)?.cast<dynamic>(),
      signeddate: fields[29] as String?,
      image: fields[27] as String?,
      accidentInsurance: fields[30] as AccidentInsurance?,
      multipleLinequestion: fields[32] as MultipleLinequestion?,
      multiplecheckbox: fields[34] as Multiplecheckbox?,
      singlechoicequestion: fields[33] as Singlechoicequestion?,
      singleLinequestion: fields[31] as SingleLinequestion?,
      rentalinsurance: fields[35] as String?,
      minorlist: (fields[36] as List?)
          ?.map((dynamic e) => (e as Map).cast<String, dynamic>())
          ?.toList(),
      protective: fields[37] as Protective?,
      wetsuit: fields[38] as Wetsuit?,
    );
  }

  @override
  void write(BinaryWriter writer, HiveModel obj) {
    writer
      ..writeByte(39)
      ..writeByte(0)
      ..write(obj.waiverid)
      ..writeByte(1)
      ..write(obj.fname)
      ..writeByte(2)
      ..write(obj.lname)
      ..writeByte(3)
      ..write(obj.gender)
      ..writeByte(4)
      ..write(obj.email)
      ..writeByte(5)
      ..write(obj.dob)
      ..writeByte(6)
      ..write(obj.phone)
      ..writeByte(7)
      ..write(obj.countrycode)
      ..writeByte(8)
      ..write(obj.waivertype)
      ..writeByte(9)
      ..write(obj.localcity)
      ..writeByte(10)
      ..write(obj.localcountry)
      ..writeByte(11)
      ..write(obj.localzipcode)
      ..writeByte(12)
      ..write(obj.localstate)
      ..writeByte(13)
      ..write(obj.localstreet)
      ..writeByte(14)
      ..write(obj.emergencyname)
      ..writeByte(15)
      ..write(obj.emergencyphone)
      ..writeByte(16)
      ..write(obj.emergencycode)
      ..writeByte(17)
      ..write(obj.city)
      ..writeByte(18)
      ..write(obj.country)
      ..writeByte(19)
      ..write(obj.zipcode)
      ..writeByte(20)
      ..write(obj.state)
      ..writeByte(21)
      ..write(obj.street)
      ..writeByte(22)
      ..write(obj.identificationType)
      ..writeByte(23)
      ..write(obj.identificationcountry)
      ..writeByte(24)
      ..write(obj.identificationstate)
      ..writeByte(25)
      ..write(obj.identificationid)
      ..writeByte(26)
      ..write(obj.hearaboutus)
      ..writeByte(27)
      ..write(obj.image)
      ..writeByte(28)
      ..write(obj.waivername)
      ..writeByte(29)
      ..write(obj.signeddate)
      ..writeByte(30)
      ..write(obj.accidentInsurance)
      ..writeByte(31)
      ..write(obj.singleLinequestion)
      ..writeByte(32)
      ..write(obj.multipleLinequestion)
      ..writeByte(33)
      ..write(obj.singlechoicequestion)
      ..writeByte(34)
      ..write(obj.multiplecheckbox)
      ..writeByte(35)
      ..write(obj.rentalinsurance)
      ..writeByte(36)
      ..write(obj.minorlist)
      ..writeByte(37)
      ..write(obj.protective)
      ..writeByte(38)
      ..write(obj.wetsuit);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is HiveModelAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}

class AccidentInsuranceAdapter extends TypeAdapter<AccidentInsurance> {
  @override
  final int typeId = 1;

  @override
  AccidentInsurance read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return AccidentInsurance(
      answer1: fields[0] as String?,
      answer2: fields[1] as String?,
    );
  }

  @override
  void write(BinaryWriter writer, AccidentInsurance obj) {
    writer
      ..writeByte(2)
      ..writeByte(0)
      ..write(obj.answer1)
      ..writeByte(1)
      ..write(obj.answer2);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is AccidentInsuranceAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}

class SingleLinequestionAdapter extends TypeAdapter<SingleLinequestion> {
  @override
  final int typeId = 2;

  @override
  SingleLinequestion read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return SingleLinequestion(
      answer: fields[0] as String?,
      options: (fields[1] as List?)?.cast<dynamic>(),
      questionid: fields[2] as String?,
    );
  }

  @override
  void write(BinaryWriter writer, SingleLinequestion obj) {
    writer
      ..writeByte(3)
      ..writeByte(0)
      ..write(obj.answer)
      ..writeByte(1)
      ..write(obj.options)
      ..writeByte(2)
      ..write(obj.questionid);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is SingleLinequestionAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}

class MultipleLinequestionAdapter extends TypeAdapter<MultipleLinequestion> {
  @override
  final int typeId = 3;

  @override
  MultipleLinequestion read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return MultipleLinequestion(
      answer: fields[0] as String?,
      options: (fields[1] as List?)?.cast<dynamic>(),
      questionid: fields[2] as String?,
    );
  }

  @override
  void write(BinaryWriter writer, MultipleLinequestion obj) {
    writer
      ..writeByte(3)
      ..writeByte(0)
      ..write(obj.answer)
      ..writeByte(1)
      ..write(obj.options)
      ..writeByte(2)
      ..write(obj.questionid);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is MultipleLinequestionAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}

class SinglechoicequestionAdapter extends TypeAdapter<Singlechoicequestion> {
  @override
  final int typeId = 4;

  @override
  Singlechoicequestion read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return Singlechoicequestion(
      answer: fields[0] as String?,
      label: fields[1] as String?,
      questionid: fields[2] as String?,
    );
  }

  @override
  void write(BinaryWriter writer, Singlechoicequestion obj) {
    writer
      ..writeByte(3)
      ..writeByte(0)
      ..write(obj.answer)
      ..writeByte(1)
      ..write(obj.label)
      ..writeByte(2)
      ..write(obj.questionid);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is SinglechoicequestionAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}

class MultiplecheckboxAdapter extends TypeAdapter<Multiplecheckbox> {
  @override
  final int typeId = 5;

  @override
  Multiplecheckbox read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return Multiplecheckbox(
      answer: fields[0] as String?,
      options: (fields[1] as List?)?.cast<dynamic>(),
      questionid: fields[2] as String?,
    );
  }

  @override
  void write(BinaryWriter writer, Multiplecheckbox obj) {
    writer
      ..writeByte(3)
      ..writeByte(0)
      ..write(obj.answer)
      ..writeByte(1)
      ..write(obj.options)
      ..writeByte(2)
      ..write(obj.questionid);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is MultiplecheckboxAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}

class ProtectiveAdapter extends TypeAdapter<Protective> {
  @override
  final int typeId = 6;

  @override
  Protective read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return Protective(
      answer1: fields[0] as String?,
      answer2: fields[1] as String?,
      agree: fields[2] as bool?,
    );
  }

  @override
  void write(BinaryWriter writer, Protective obj) {
    writer
      ..writeByte(3)
      ..writeByte(0)
      ..write(obj.answer1)
      ..writeByte(1)
      ..write(obj.answer2)
      ..writeByte(2)
      ..write(obj.agree);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is ProtectiveAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}

class WetsuitAdapter extends TypeAdapter<Wetsuit> {
  @override
  final int typeId = 7;

  @override
  Wetsuit read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return Wetsuit(
      answer1: fields[0] as String?,
      answer2: fields[1] as String?,
      agree: fields[2] as bool?,
    );
  }

  @override
  void write(BinaryWriter writer, Wetsuit obj) {
    writer
      ..writeByte(3)
      ..writeByte(0)
      ..write(obj.answer1)
      ..writeByte(1)
      ..write(obj.answer2)
      ..writeByte(2)
      ..write(obj.agree);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is WetsuitAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}

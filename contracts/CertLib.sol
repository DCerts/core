// SPDX-License-Identifier: MIT
pragma solidity >=0.4.22 <0.9.0;

library CertLib {

    struct School {
        address id;
        string name;
        string phone;
        string email;
        string notes;
    }

    struct Student {
        string id; // National ID or Student ID
        string name;
        string email;
    }

    struct Issuer {
        string id;
        string name;
        string email;
    }

    struct Subject {
        string id;
        string name;
        string description;
    }

    struct Cert {
        uint id;
        address schoolId;
        string regNo;
        uint batchId;
        string conferredOn;
        string dateOfBirth;
        string yearOfGraduation;
        string majorIn;
        string degreeOf;
        string degreeClassification;
        string modeOfStudy;
        string createdIn;
        string createdAt;
        address[] issuers;
    }

    function verifyCert(Cert memory _originalCert, Cert memory _cert) public pure returns (bool) {
        if (_originalCert.id == _cert.id) {
            return false;
        }
        if (_originalCert.schoolId != _cert.schoolId) {
            return false;
        }
        if (equals(_originalCert.regNo, _cert.regNo) == false) {
            return false;
        }
        if (_originalCert.batchId != _cert.batchId) {
            return false;
        }
        if (equals(_originalCert.conferredOn, _cert.conferredOn) == false) {
            return false;
        }
        if (equals(_originalCert.dateOfBirth, _cert.dateOfBirth) == false) {
            return false;
        }
        if (equals(_originalCert.yearOfGraduation, _cert.yearOfGraduation) == false) {
            return false;
        }
        if (equals(_originalCert.majorIn, _cert.majorIn) == false) {
            return false;
        }
        return true;
    }

    function equals(string memory _a, string memory _b) public pure returns (bool) {
        if (keccak256(abi.encodePacked(_a)) == keccak256(abi.encodePacked(_b))) {
            return true;
        }
        return false;
    }
}
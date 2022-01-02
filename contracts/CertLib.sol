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
        string studentId;
        string subjectId;
        address[] issuers;
        string semester;
        string grade;
        string gradeType;
        uint batchId;
    }

    function verifyCert(Cert memory _originalCert, Cert memory _cert) public pure returns (bool) {
        if (_originalCert.id == _cert.id) {
            return false;
        }
        if (_originalCert.schoolId != _cert.schoolId) {
            return false;
        }
        if (equals(_originalCert.studentId, _cert.studentId) == false) {
            return false;
        }
        if (equals(_originalCert.subjectId, _cert.subjectId) == false) {
            return false;
        }
        if (equals(_originalCert.semester, _cert.semester) == false) {
            return false;
        }
        if (equals(_originalCert.gradeType, _cert.gradeType) == false) {
            return false;
        }
        if (equals(_originalCert.grade, _cert.grade) == false) {
            return false;
        }
        if (_originalCert.batchId != _cert.batchId) {
            return false;
        }
        for (uint i = 0; i < _originalCert.issuers.length; i++) {
            bool found = false;
            for (uint j = 0; j < _cert.issuers.length; j++) {
                if (_originalCert.issuers[i] == _cert.issuers[j]) {
                    found = true;
                    break;
                }
            }
            if (found == false) {
                return false;
            }
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
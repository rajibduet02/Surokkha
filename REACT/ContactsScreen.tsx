import { motion } from "motion/react";
import {
  Users,
  Plus,
  Phone,
  Mail,
  Shield,
  Star,
  ArrowLeft,
  MoreVertical,
} from "lucide-react";
import { Link } from "react-router";
import { FloatingNav } from "../components/FloatingNav";
import { useUser } from "../context/UserContext";

export function ContactsScreen() {
  const { isChild, isWoman } = useUser();

  // Different default contacts based on profile type
  const contactsWoman = [
    {
      name: "Fatima Rahman",
      relation: "Mother",
      phone: "+880 1712-345678",
      email: "fatima.r@email.com",
      priority: 1,
      verified: true,
    },
    {
      name: "Karim Ahmed",
      relation: "Father",
      phone: "+880 1812-345678",
      email: "karim.a@email.com",
      priority: 1,
      verified: true,
    },
    {
      name: "Nadia Islam",
      relation: "Sister",
      phone: "+880 1912-345678",
      email: "nadia.i@email.com",
      priority: 2,
      verified: true,
    },
    {
      name: "Dr. Hasan Ali",
      relation: "Colleague",
      phone: "+880 1612-345678",
      email: "dr.hasan@work.com",
      priority: 2,
      verified: false,
    },
    {
      name: "Riya Chowdhury",
      relation: "Best Friend",
      phone: "+880 1512-345678",
      email: "riya.c@email.com",
      priority: 3,
      verified: true,
    },
  ];

  const contactsChild = [
    {
      name: "Fatima Rahman",
      relation: "Mother",
      phone: "+880 1712-345678",
      email: "fatima.r@email.com",
      priority: 1,
      verified: true,
    },
    {
      name: "Karim Ahmed",
      relation: "Father",
      phone: "+880 1812-345678",
      email: "karim.a@email.com",
      priority: 1,
      verified: true,
    },
    {
      name: "Ms. Farzana Haque",
      relation: "Teacher",
      phone: "+880 1912-345678",
      email: "farzana.h@school.edu",
      priority: 2,
      verified: true,
    },
    {
      name: "Uncle Rashid",
      relation: "Trusted Adult",
      phone: "+880 1612-345678",
      email: "rashid@email.com",
      priority: 2,
      verified: true,
    },
    {
      name: "Aunt Shirin",
      relation: "Family Friend",
      phone: "+880 1512-345678",
      email: "shirin@email.com",
      priority: 3,
      verified: true,
    },
  ];

  const contacts = isChild ? contactsChild : contactsWoman;

  return (
    <div className="min-h-screen bg-gradient-to-b from-[#0A0A0F] via-[#1A1A22] to-[#0A0A0F]">
      <div className="w-full max-w-[430px] mx-auto px-6 py-8 space-y-8 pb-32">
        {/* Header */}
        <motion.div
          initial={{ opacity: 0, y: -20 }}
          animate={{ opacity: 1, y: 0 }}
          className="flex items-center justify-between"
        >
          <Link to="/dashboard">
            <button className="w-10 h-10 bg-[#1A1A22] rounded-[12px] border border-[#D4AF37]/20 flex items-center justify-center">
              <ArrowLeft className="w-5 h-5 text-[#D4AF37]" />
            </button>
          </Link>
          <h2 className="text-white text-xl font-bold">Safe Contacts</h2>
          <button className="w-10 h-10 bg-gradient-to-br from-[#D4AF37] to-[#F6D365] rounded-[12px] flex items-center justify-center">
            <Plus className="w-5 h-5 text-[#0A0A0F]" strokeWidth={2.5} />
          </button>
        </motion.div>

        {/* Info Banner */}
        <motion.div
          initial={{ opacity: 0, y: 20 }}
          animate={{ opacity: 1, y: 0 }}
          transition={{ delay: 0.1 }}
          className="bg-gradient-to-r from-[#D4AF37]/10 to-[#F6D365]/10 p-4 rounded-[20px] border border-[#D4AF37]/30"
        >
          <div className="flex items-start gap-3">
            <Shield className="w-5 h-5 text-[#D4AF37] flex-shrink-0 mt-0.5" />
            <div>
              <p className="text-[#D4AF37] text-sm font-medium">
                Emergency Protocol Active
              </p>
              <p className="text-[#8A8A92] text-xs mt-1">
                These contacts will be notified instantly during an SOS alert
                with your live location and emergency details.
              </p>
            </div>
          </div>
        </motion.div>

        {/* Contacts List */}
        <motion.div
          initial={{ opacity: 0, y: 20 }}
          animate={{ opacity: 1, y: 0 }}
          transition={{ delay: 0.2 }}
          className="space-y-4"
        >
          <div className="flex items-center justify-between px-2">
            <h3 className="text-white font-semibold">
              Trusted Contacts ({contacts.length})
            </h3>
            <span className="text-[#8A8A92] text-sm">Max: 10</span>
          </div>

          <div className="space-y-3">
            {contacts.map((contact, index) => (
              <motion.div
                key={contact.name}
                initial={{ opacity: 0, x: -20 }}
                animate={{ opacity: 1, x: 0 }}
                transition={{ delay: 0.3 + index * 0.1 }}
                className="bg-gradient-to-br from-[#1A1A22] to-[#2A2A32] p-4 rounded-[20px] border border-[#D4AF37]/10 hover:border-[#D4AF37]/30 transition-all"
              >
                <div className="flex items-start gap-4">
                  {/* Avatar */}
                  <div className="relative flex-shrink-0">
                    <div className="w-14 h-14 bg-gradient-to-br from-[#D4AF37] to-[#F6D365] rounded-full flex items-center justify-center">
                      <span className="text-[#0A0A0F] font-bold text-lg">
                        {contact.name.charAt(0)}
                      </span>
                    </div>
                    {contact.priority === 1 && (
                      <div className="absolute -top-1 -right-1 w-6 h-6 bg-[#D4AF37] rounded-full flex items-center justify-center border-2 border-[#1A1A22]">
                        <Star
                          className="w-3 h-3 text-[#0A0A0F]"
                          fill="#0A0A0F"
                        />
                      </div>
                    )}
                    {contact.verified && (
                      <div className="absolute -bottom-1 -right-1 w-6 h-6 bg-[#10B981] rounded-full flex items-center justify-center border-2 border-[#1A1A22]">
                        <Shield className="w-3 h-3 text-white" />
                      </div>
                    )}
                  </div>

                  {/* Info */}
                  <div className="flex-1 min-w-0">
                    <div className="flex items-start justify-between mb-2">
                      <div>
                        <h4 className="text-white font-semibold">
                          {contact.name}
                        </h4>
                        <p className="text-[#8A8A92] text-sm">
                          {contact.relation}
                        </p>
                      </div>
                      <button className="w-8 h-8 bg-[#2A2A32] rounded-[10px] flex items-center justify-center hover:bg-[#3A3A42] transition-all">
                        <MoreVertical className="w-4 h-4 text-[#8A8A92]" />
                      </button>
                    </div>

                    <div className="space-y-2">
                      <div className="flex items-center gap-2">
                        <Phone className="w-3.5 h-3.5 text-[#8A8A92]" />
                        <span className="text-[#8A8A92] text-xs">
                          {contact.phone}
                        </span>
                      </div>
                      <div className="flex items-center gap-2">
                        <Mail className="w-3.5 h-3.5 text-[#8A8A92]" />
                        <span className="text-[#8A8A92] text-xs truncate">
                          {contact.email}
                        </span>
                      </div>
                    </div>

                    <div className="flex items-center gap-2 mt-3">
                      <div
                        className={`px-2.5 py-1 rounded-full ${
                          contact.priority === 1
                            ? "bg-[#D4AF37]/10"
                            : contact.priority === 2
                            ? "bg-[#F6D365]/10"
                            : "bg-[#8A8A92]/10"
                        }`}
                      >
                        <span
                          className={`text-xs font-medium ${
                            contact.priority === 1
                              ? "text-[#D4AF37]"
                              : contact.priority === 2
                              ? "text-[#F6D365]"
                              : "text-[#8A8A92]"
                          }`}
                        >
                          Priority {contact.priority}
                        </span>
                      </div>
                      {contact.verified && (
                        <div className="px-2.5 py-1 rounded-full bg-[#10B981]/10">
                          <span className="text-[#10B981] text-xs font-medium">
                            Verified
                          </span>
                        </div>
                      )}
                    </div>
                  </div>
                </div>
              </motion.div>
            ))}
          </div>
        </motion.div>

        {/* Add Contact CTA */}
        <motion.button
          initial={{ opacity: 0, y: 20 }}
          animate={{ opacity: 1, y: 0 }}
          transition={{ delay: 0.8 }}
          className="w-full bg-gradient-to-br from-[#1A1A22] to-[#2A2A32] border-2 border-dashed border-[#D4AF37]/30 text-[#D4AF37] font-semibold py-4 rounded-[20px] hover:border-[#D4AF37]/50 hover:bg-[#D4AF37]/5 transition-all flex items-center justify-center gap-2"
        >
          <Plus className="w-5 h-5" strokeWidth={2.5} />
          <span>Add Another Contact</span>
        </motion.button>

        {/* Priority Info */}
        <motion.div
          initial={{ opacity: 0 }}
          animate={{ opacity: 1 }}
          transition={{ delay: 0.9 }}
          className="bg-[#1A1A22] p-4 rounded-[20px] border border-[#D4AF37]/10 space-y-3"
        >
          <h4 className="text-white text-sm font-semibold flex items-center gap-2">
            <Star className="w-4 h-4 text-[#D4AF37]" />
            Priority Levels
          </h4>
          <div className="space-y-2 text-xs text-[#8A8A92]">
            <p>
              <strong className="text-[#D4AF37]">Priority 1:</strong> Notified
              instantly + Auto-call
            </p>
            <p>
              <strong className="text-[#F6D365]">Priority 2:</strong> Notified
              within 10 seconds
            </p>
            <p>
              <strong className="text-[#8A8A92]">Priority 3:</strong> Notified
              after Priority 1 & 2
            </p>
          </div>
        </motion.div>
      </div>
      <FloatingNav />
    </div>
  );
}
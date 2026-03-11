import { motion } from "motion/react";
import {
  User,
  Crown,
  Shield,
  Bell,
  Globe,
  FileText,
  Lock,
  ChevronRight,
  ArrowLeft,
  Phone,
  MapPin,
  CheckCircle2,
  Video,
  Camera,
} from "lucide-react";
import { Link } from "react-router";
import { useState } from "react";
import { FloatingNav } from "../components/FloatingNav";

export function SettingsScreen() {
  const [selectedLanguage, setSelectedLanguage] = useState("english");

  const settingsSections = [
    {
      title: "Account",
      items: [
        {
          icon: User,
          label: "Personal Information",
          description: "Name, phone, email",
          link: "/profile",
        },
        {
          icon: Crown,
          label: "Subscription Status",
          description: "Premium • 12 days trial left",
          link: "/premium",
          badge: "Premium",
        },
      ],
    },
    {
      title: "Emergency Settings",
      items: [
        {
          icon: Phone,
          label: "Emergency Contacts",
          description: "5 contacts added",
          link: "/contacts",
        },
        {
          icon: MapPin,
          label: "Safe Zones",
          description: "3 zones configured",
          link: "/safe-zones",
        },
        {
          icon: Bell,
          label: "Alert Preferences",
          description: "Customize notifications",
          link: "#",
        },
      ],
    },
    {
      title: "App Settings",
      items: [
        {
          icon: Globe,
          label: "Language",
          description: selectedLanguage === "english" ? "English" : "বাংলা",
          link: "#",
          action: "language",
        },
        {
          icon: Shield,
          label: "Privacy & Security",
          description: "Data protection settings",
          link: "#",
        },
      ],
    },
    {
      title: "Legal",
      items: [
        {
          icon: FileText,
          label: "Terms of Service",
          description: "Read our terms",
          link: "#",
        },
        {
          icon: Lock,
          label: "Privacy Policy",
          description: "How we protect your data",
          link: "#",
        },
      ],
    },
  ];

  return (
    <div className="min-h-screen bg-[#0A0A0F]">
      <div className="w-full max-w-[430px] mx-auto px-6 py-8 space-y-6 pb-32">
        {/* Header */}
        <motion.div
          initial={{ opacity: 0, y: -20 }}
          animate={{ opacity: 1, y: 0 }}
          className="flex items-center justify-between"
        >
          <div className="flex items-center gap-3">
            <Link to="/dashboard">
              <button className="w-10 h-10 bg-[#1A1A22] rounded-[12px] border border-[#D4AF37]/20 flex items-center justify-center">
                <ArrowLeft className="w-5 h-5 text-[#D4AF37]" />
              </button>
            </Link>
            <h1 className="text-white text-2xl font-bold">Settings</h1>
          </div>
        </motion.div>

        {/* Profile Card */}
        <motion.div
          initial={{ opacity: 0, scale: 0.95 }}
          animate={{ opacity: 1, scale: 1 }}
          transition={{ delay: 0.1 }}
          className="bg-gradient-to-br from-[#1A1A22] to-[#2A2A32] p-6 rounded-[24px] border border-[#D4AF37]/20"
        >
          <div className="flex items-center gap-4">
            {/* Profile Avatar */}
            <div className="relative">
              <div className="w-16 h-16 bg-gradient-to-br from-[#D4AF37] to-[#F6D365] rounded-full flex items-center justify-center">
                <span className="text-[#0A0A0F] text-2xl font-bold">SR</span>
              </div>
              {/* Premium Badge */}
              <div className="absolute -bottom-1 -right-1 w-6 h-6 bg-gradient-to-br from-[#D4AF37] to-[#F6D365] rounded-full flex items-center justify-center border-2 border-[#1A1A22]">
                <Crown className="w-3.5 h-3.5 text-[#0A0A0F]" fill="#0A0A0F" />
              </div>
            </div>

            {/* Profile Info */}
            <div className="flex-1">
              <h3 className="text-white text-lg font-bold">Sarah Rahman</h3>
              <p className="text-[#8A8A92] text-sm">+880 1712-345678</p>
              <div className="flex items-center gap-1.5 mt-1">
                <CheckCircle2 className="w-3.5 h-3.5 text-[#10B981]" />
                <span className="text-[#10B981] text-xs font-medium">
                  Verified Account
                </span>
              </div>
            </div>

            <ChevronRight className="w-5 h-5 text-[#8A8A92]" />
          </div>
        </motion.div>

        {/* Settings Sections */}
        {settingsSections.map((section, sectionIdx) => (
          <motion.div
            key={section.title}
            initial={{ opacity: 0, y: 20 }}
            animate={{ opacity: 1, y: 0 }}
            transition={{ delay: 0.2 + sectionIdx * 0.1 }}
            className="space-y-3"
          >
            <h3 className="text-white font-semibold text-sm px-2">
              {section.title}
            </h3>

            <div className="bg-[#1A1A22]/60 backdrop-blur-xl rounded-[20px] border border-[#D4AF37]/10 overflow-hidden">
              {section.items.map((item, itemIdx) => {
                const Icon = item.icon;

                // Language Toggle
                if (item.action === "language") {
                  return (
                    <div
                      key={itemIdx}
                      className="p-4 border-b border-[#2A2A32] last:border-b-0"
                    >
                      <div className="flex items-center justify-between mb-3">
                        <div className="flex items-center gap-3">
                          <div className="w-10 h-10 bg-[#D4AF37]/10 rounded-[12px] flex items-center justify-center">
                            <Icon className="w-5 h-5 text-[#D4AF37]" />
                          </div>
                          <div>
                            <p className="text-white font-medium text-sm">
                              {item.label}
                            </p>
                            <p className="text-[#8A8A92] text-xs">
                              {item.description}
                            </p>
                          </div>
                        </div>
                      </div>

                      {/* Language Toggle */}
                      <div className="flex gap-2">
                        <button
                          onClick={() => setSelectedLanguage("english")}
                          className={`flex-1 py-2.5 rounded-[12px] text-sm font-medium transition-all ${
                            selectedLanguage === "english"
                              ? "bg-gradient-to-r from-[#D4AF37] to-[#F6D365] text-[#0A0A0F]"
                              : "bg-[#2A2A32] text-[#8A8A92]"
                          }`}
                        >
                          English
                        </button>
                        <button
                          onClick={() => setSelectedLanguage("bangla")}
                          className={`flex-1 py-2.5 rounded-[12px] text-sm font-medium transition-all ${
                            selectedLanguage === "bangla"
                              ? "bg-gradient-to-r from-[#D4AF37] to-[#F6D365] text-[#0A0A0F]"
                              : "bg-[#2A2A32] text-[#8A8A92]"
                          }`}
                        >
                          বাংলা
                        </button>
                      </div>
                    </div>
                  );
                }

                // Regular Link Item
                return (
                  <Link key={itemIdx} to={item.link}>
                    <button className="w-full p-4 border-b border-[#2A2A32] last:border-b-0 hover:bg-[#2A2A32]/30 transition-all">
                      <div className="flex items-center justify-between">
                        <div className="flex items-center gap-3">
                          <div className="w-10 h-10 bg-[#D4AF37]/10 rounded-[12px] flex items-center justify-center">
                            <Icon className="w-5 h-5 text-[#D4AF37]" />
                          </div>
                          <div className="text-left">
                            <p className="text-white font-medium text-sm">
                              {item.label}
                            </p>
                            <p className="text-[#8A8A92] text-xs">
                              {item.description}
                            </p>
                          </div>
                        </div>
                        <div className="flex items-center gap-2">
                          {item.badge && (
                            <div className="bg-gradient-to-r from-[#D4AF37] to-[#F6D365] px-2 py-1 rounded-[8px]">
                              <span className="text-[#0A0A0F] text-xs font-semibold">
                                {item.badge}
                              </span>
                            </div>
                          )}
                          <ChevronRight className="w-5 h-5 text-[#8A8A92]" />
                        </div>
                      </div>
                    </button>
                  </Link>
                );
              })}
            </div>
          </motion.div>
        ))}

        {/* App Version */}
        <motion.div
          initial={{ opacity: 0 }}
          animate={{ opacity: 1 }}
          transition={{ delay: 0.8 }}
          className="text-center pt-4"
        >
          <p className="text-[#8A8A92] text-xs">
            Safety Shield v2.1.0
          </p>
          <p className="text-[#8A8A92] text-xs mt-1">
            © 2026 Safety Shield. All rights reserved.
          </p>
        </motion.div>

        {/* Background Glow Effects */}
        <div className="fixed top-20 left-0 w-64 h-64 bg-[#D4AF37]/5 rounded-full blur-3xl -z-10 pointer-events-none" />
        <div className="fixed bottom-40 right-0 w-64 h-64 bg-[#F6D365]/5 rounded-full blur-3xl -z-10 pointer-events-none" />
      </div>

      {/* Floating Navigation */}
      <FloatingNav />
    </div>
  );
}
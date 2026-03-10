import { motion } from "motion/react";
import { Map, Plus, MapPin, ArrowLeft, Bell, BellOff } from "lucide-react";
import { Link } from "react-router";
import { useState } from "react";
import { FloatingNav } from "../components/FloatingNav";
import { useUser } from "../context/UserContext";

export function SafeZonesScreen() {
  const { isChild, isWoman } = useUser();

  // Different default zones based on profile type
  const zonesWoman = [
    {
      id: 1,
      name: "Home",
      address: "Gulshan 2, Dhaka",
      radius: "200m",
      entryAlert: true,
      exitAlert: true,
      active: true,
    },
    {
      id: 2,
      name: "Office",
      address: "Banani, Dhaka",
      radius: "150m",
      entryAlert: false,
      exitAlert: true,
      active: true,
    },
    {
      id: 3,
      name: "Sister's House",
      address: "Dhanmondi, Dhaka",
      radius: "180m",
      entryAlert: true,
      exitAlert: true,
      active: false,
    },
  ];

  const zonesChild = [
    {
      id: 1,
      name: "Home",
      address: "Gulshan 2, Dhaka",
      radius: "200m",
      entryAlert: true,
      exitAlert: true,
      active: true,
    },
    {
      id: 2,
      name: "School",
      address: "Banani Model School, Dhaka",
      radius: "250m",
      entryAlert: true,
      exitAlert: true,
      active: true,
    },
    {
      id: 3,
      name: "Uncle's House",
      address: "Dhanmondi, Dhaka",
      radius: "180m",
      entryAlert: true,
      exitAlert: true,
      active: true,
    },
  ];

  const initialZones = isChild ? zonesChild : zonesWoman;
  const [zones, setZones] = useState(initialZones);

  const toggleZone = (id: number) => {
    setZones(
      zones.map((zone) =>
        zone.id === id ? { ...zone, active: !zone.active } : zone
      )
    );
  };

  const toggleEntryAlert = (id: number) => {
    setZones(
      zones.map((zone) =>
        zone.id === id ? { ...zone, entryAlert: !zone.entryAlert } : zone
      )
    );
  };

  const toggleExitAlert = (id: number) => {
    setZones(
      zones.map((zone) =>
        zone.id === id ? { ...zone, exitAlert: !zone.exitAlert } : zone
      )
    );
  };

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
            <div>
              <h1 className="text-white text-2xl font-bold">Safe Zones</h1>
              <p className="text-[#8A8A92] text-sm">
                {zones.filter((z) => z.active).length} active zones
              </p>
            </div>
          </div>
        </motion.div>

        {/* Add Zone Button */}
        <motion.button
          initial={{ opacity: 0, scale: 0.95 }}
          animate={{ opacity: 1, scale: 1 }}
          transition={{ delay: 0.1 }}
          whileHover={{ scale: 1.01 }}
          whileTap={{ scale: 0.99 }}
          className="w-full bg-gradient-to-r from-[#D4AF37] to-[#F6D365] p-5 rounded-[20px] flex items-center justify-center gap-3 shadow-lg shadow-[#D4AF37]/20"
        >
          <Plus className="w-6 h-6 text-[#0A0A0F]" strokeWidth={2.5} />
          <span className="text-[#0A0A0F] text-lg font-bold">Add New Safe Zone</span>
        </motion.button>

        {/* Info Card */}
        <motion.div
          initial={{ opacity: 0, y: 20 }}
          animate={{ opacity: 1, y: 0 }}
          transition={{ delay: 0.2 }}
          className="bg-[#D4AF37]/10 p-4 rounded-[20px] border border-[#D4AF37]/30"
        >
          <p className="text-[#D4AF37] text-sm text-center">
            <strong>Safe Zones</strong> notify your guardians when you enter or exit
            designated areas for added security.
          </p>
        </motion.div>

        {/* Zones List */}
        <motion.div
          initial={{ opacity: 0, y: 20 }}
          animate={{ opacity: 1, y: 0 }}
          transition={{ delay: 0.3 }}
          className="space-y-4"
        >
          <h3 className="text-white font-semibold text-lg px-2">Your Zones</h3>

          {zones.map((zone, idx) => (
            <motion.div
              key={zone.id}
              initial={{ opacity: 0, x: -20 }}
              animate={{ opacity: 1, x: 0 }}
              transition={{ delay: 0.4 + idx * 0.1 }}
              className={`bg-[#1A1A22]/60 backdrop-blur-xl rounded-[20px] border overflow-hidden transition-all ${
                zone.active
                  ? "border-[#D4AF37]/30 shadow-lg shadow-[#D4AF37]/5"
                  : "border-[#2A2A32]"
              }`}
            >
              {/* Main Zone Info */}
              <div className="p-5 space-y-4">
                {/* Top Row */}
                <div className="flex items-start justify-between">
                  <div className="flex items-start gap-3 flex-1">
                    {/* Icon */}
                    <div
                      className={`w-12 h-12 rounded-[14px] flex items-center justify-center flex-shrink-0 ${
                        zone.active
                          ? "bg-gradient-to-br from-[#D4AF37] to-[#F6D365]"
                          : "bg-[#2A2A32]"
                      }`}
                    >
                      <MapPin
                        className={`w-6 h-6 ${
                          zone.active ? "text-[#0A0A0F]" : "text-[#8A8A92]"
                        }`}
                      />
                    </div>

                    {/* Zone Details */}
                    <div className="flex-1">
                      <h4 className="text-white font-semibold text-lg">
                        {zone.name}
                      </h4>
                      <p className="text-[#8A8A92] text-sm mt-0.5">
                        {zone.address}
                      </p>
                      <div className="flex items-center gap-2 mt-2">
                        <div className="bg-[#D4AF37]/10 px-2 py-1 rounded-[8px]">
                          <span className="text-[#D4AF37] text-xs font-medium">
                            {zone.radius}
                          </span>
                        </div>
                        {zone.active && (
                          <div className="flex items-center gap-1">
                            <motion.div
                              animate={{ scale: [1, 1.3, 1] }}
                              transition={{ duration: 2, repeat: Infinity }}
                              className="w-1.5 h-1.5 bg-[#10B981] rounded-full"
                            />
                            <span className="text-[#10B981] text-xs font-medium">
                              Active
                            </span>
                          </div>
                        )}
                      </div>
                    </div>
                  </div>

                  {/* Toggle Switch */}
                  <button
                    onClick={() => toggleZone(zone.id)}
                    className={`relative w-14 h-8 rounded-full transition-all flex-shrink-0 ${
                      zone.active
                        ? "bg-gradient-to-r from-[#D4AF37] to-[#F6D365]"
                        : "bg-[#2A2A32]"
                    }`}
                  >
                    <motion.div
                      animate={{ x: zone.active ? 26 : 4 }}
                      transition={{ type: "spring", stiffness: 500, damping: 30 }}
                      className={`absolute top-1 w-6 h-6 rounded-full shadow-lg ${
                        zone.active ? "bg-[#0A0A0F]" : "bg-[#8A8A92]"
                      }`}
                    />
                  </button>
                </div>

                {/* Notification Settings */}
                {zone.active && (
                  <motion.div
                    initial={{ opacity: 0, height: 0 }}
                    animate={{ opacity: 1, height: "auto" }}
                    className="space-y-2 pt-2 border-t border-[#2A2A32]"
                  >
                    <p className="text-[#8A8A92] text-xs font-medium mb-2">
                      Notifications
                    </p>

                    {/* Entry Alert */}
                    <button
                      onClick={() => toggleEntryAlert(zone.id)}
                      className={`w-full flex items-center justify-between p-3 rounded-[12px] transition-all ${
                        zone.entryAlert
                          ? "bg-[#10B981]/10 border border-[#10B981]/30"
                          : "bg-[#2A2A32]/50 border border-transparent"
                      }`}
                    >
                      <div className="flex items-center gap-2">
                        <Bell
                          className={`w-4 h-4 ${
                            zone.entryAlert ? "text-[#10B981]" : "text-[#8A8A92]"
                          }`}
                        />
                        <span
                          className={`text-sm ${
                            zone.entryAlert ? "text-[#10B981]" : "text-[#8A8A92]"
                          }`}
                        >
                          Entry Alert
                        </span>
                      </div>
                      <div
                        className={`w-5 h-5 rounded-full border-2 flex items-center justify-center ${
                          zone.entryAlert
                            ? "border-[#10B981] bg-[#10B981]"
                            : "border-[#8A8A92]"
                        }`}
                      >
                        {zone.entryAlert && (
                          <motion.div
                            initial={{ scale: 0 }}
                            animate={{ scale: 1 }}
                            className="w-2 h-2 bg-white rounded-full"
                          />
                        )}
                      </div>
                    </button>

                    {/* Exit Alert */}
                    <button
                      onClick={() => toggleExitAlert(zone.id)}
                      className={`w-full flex items-center justify-between p-3 rounded-[12px] transition-all ${
                        zone.exitAlert
                          ? "bg-[#F59E0B]/10 border border-[#F59E0B]/30"
                          : "bg-[#2A2A32]/50 border border-transparent"
                      }`}
                    >
                      <div className="flex items-center gap-2">
                        <BellOff
                          className={`w-4 h-4 ${
                            zone.exitAlert ? "text-[#F59E0B]" : "text-[#8A8A92]"
                          }`}
                        />
                        <span
                          className={`text-sm ${
                            zone.exitAlert ? "text-[#F59E0B]" : "text-[#8A8A92]"
                          }`}
                        >
                          Exit Alert
                        </span>
                      </div>
                      <div
                        className={`w-5 h-5 rounded-full border-2 flex items-center justify-center ${
                          zone.exitAlert
                            ? "border-[#F59E0B] bg-[#F59E0B]"
                            : "border-[#8A8A92]"
                        }`}
                      >
                        {zone.exitAlert && (
                          <motion.div
                            initial={{ scale: 0 }}
                            animate={{ scale: 1 }}
                            className="w-2 h-2 bg-white rounded-full"
                          />
                        )}
                      </div>
                    </button>
                  </motion.div>
                )}
              </div>
            </motion.div>
          ))}
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